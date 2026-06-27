import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";
import { getGeminiModel, genAI } from "../_shared/clients/gemini.ts";
import { buildPrompt } from "./prompt-builder/index.ts";
import { processGeminiResponse } from "./response-processor/index.ts";

const EMBEDDING_MODEL = "text-embedding-004";
const CHAT_MODEL = "gemini-1.5-flash";
const AI_VERSION = "f2-prompt";

// ── Helpers ──────────────────────────────────────────────────────────────────

function toNonNegativeInteger(value: unknown): number {
  const numberValue = Number(value ?? 0);
  if (!Number.isFinite(numberValue) || numberValue < 0) {
    return 0;
  }

  return Math.round(numberValue);
}

function estimateCostUsd(promptTokens: number, completionTokens: number): number | null {
  const inputRate = Number(Deno.env.get("GEMINI_INPUT_USD_PER_1M_TOKENS") ?? 0);
  const outputRate = Number(Deno.env.get("GEMINI_OUTPUT_USD_PER_1M_TOKENS") ?? 0);

  if (!Number.isFinite(inputRate) || !Number.isFinite(outputRate) || (inputRate <= 0 && outputRate <= 0)) {
    return null;
  }

  const cost = (promptTokens / 1_000_000) * inputRate + (completionTokens / 1_000_000) * outputRate;
  return Number(cost.toFixed(6));
}

/**
 * Normalize provider-specific role names to standard schema roles.
 * Gemini uses "model", OpenAI/Claude use "assistant". We standardize to "assistant".
 */
function normalizeRole(role: string): "user" | "assistant" | "system" {
  if (role === "model" || role === "assistant") return "assistant";
  if (role === "system") return "system";
  return "user";
}

/**
 * Generate a short, readable conversation title from the user's first message.
 * Capitalizes first letter and truncates to 60 chars.
 */
function generateTitle(message: string): string {
  const cleaned = message.trim().replace(/\s+/g, " ");
  const truncated = cleaned.length > 60 ? cleaned.substring(0, 57) + "..." : cleaned;
  // Capitalize first letter
  return truncated.charAt(0).toUpperCase() + truncated.slice(1);
}

/**
 * Simple SHA-256 hash for prompt deduplication/comparison.
 */
async function sha256(text: string): Promise<string> {
  const encoder = new TextEncoder();
  const data = encoder.encode(text);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map((b) => b.toString(16).padStart(2, "0")).join("");
}

// ── Main Handler ─────────────────────────────────────────────────────────────

export default {
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      const requestStartedAt = performance.now();
      let embeddingLatencyMs: number | null = null;
      let vectorSearchLatencyMs: number | null = null;
      let generationLatencyMs: number | null = null;
      let usageMetadata: Record<string, unknown> = {};

      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { message, conversationId } = await req.json();

      if (!message) {
        return errorResponse("Missing required field: message");
      }

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // 1. Get user profile and companyId
      const { data: profile, error: profileError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("company_id")
        .eq("id", userId)
        .single();

      if (profileError || !profile) {
        return errorResponse(`Could not find profile for user ${userId}: ${profileError?.message || "Not found"}`, 404);
      }

      const companyId = profile.company_id;

      // 2. Skill Routing
      const { data: routingResult, error: routingError } = await ctx.supabaseAdmin
        .rpc("route_skill", {
          p_company_id: companyId,
          p_question: message
        });
      
      let routedSkill = "knowledge_assistant";
      let routedConfidence = 0.5;
      let routingReason = "Fallback default";
      let needsClarification = false;
      let routingAlternatives: string[] = [];

      if (!routingError && routingResult) {
        routedSkill = routingResult.skill || routingResult.primary;
        routedConfidence = routingResult.confidence;
        routingReason = routingResult.routing_reason;
        needsClarification = routingResult.needs_clarification;
        routingAlternatives = routingResult.alternatives || [];
      }

      // Log skill route analytics
      await ctx.supabaseAdmin
        .from("ai_skill_routes")
        .insert({
          company_id: companyId,
          profile_id: userId,
          question: message,
          skill: routedSkill,
          confidence: routedConfidence,
          routing_reason: routingReason,
          alternatives: routingAlternatives,
          needs_clarification: needsClarification
        });

      // Ensure F3–F8 skills only.
      if (!['team_performance', 'compliance_coach', 'knowledge_assistant', 'meeting_coach', 'task_coach', 'leadership_advisor', 'member_success', 'retention_risk', 'growth_opportunity', 'promotion_advisor', 'recognition_coach', 'executive_advisor'].includes(routedSkill)) {
        return successResponse({
          response: {
            summary: "Skill coming soon.",
            recommended_actions: [],
            confidence: 1.0
          },
          conversationId: conversationId
        }, 200);
      }

      // 3. Build Operational Context via context-builder
      let contextLatencyMs: number | null = null;
      let operationalContext: any = {};
      let contextSnapshot: any = {};

      const contextStartedAt = performance.now();
      const { data: cbResult, error: cbError } = await ctx.supabaseAdmin.functions.invoke("context-builder", {
        body: {
          companyId,
          profileId: userId,
          skill: routedSkill,
          question: message
        }
      });
      contextLatencyMs = Math.round(performance.now() - contextStartedAt);

      if (!cbError && cbResult?.context) {
         operationalContext = cbResult.context;
         contextSnapshot = cbResult;
      } else {
         console.error("Context Builder failed:", cbError);
      }

      // If clarification is needed, we could potentially return early here,
      // but for F1 let's just pass it to Gemini to ask the user.
      
      // 4. Generate embedding for user's question (if knowledge assistant or we want hybrid)
      let embeddingValues: number[] = [];
      let contextChunks: any[] = [];
      
      // Only do heavy RAG if knowledge_assistant is chosen or fallback
      if (routedSkill === "knowledge_assistant" || routedSkill === "system_assistant") {
        try {
          const embeddingStartedAt = performance.now();
          const embedModel = getGeminiModel(EMBEDDING_MODEL);
          const embedResult = await embedModel.embedContent(message);
          embeddingLatencyMs = Math.round(performance.now() - embeddingStartedAt);
          embeddingValues = embedResult.embedding?.values || [];
        } catch (embedErr: any) {
          console.error("Failed to generate embedding for question:", embedErr);
        }

        // Vector search for matching document chunks
        if (embeddingValues.length > 0) {
          const vectorStr = `[${embeddingValues.join(",")}]`;
          const vectorSearchStartedAt = performance.now();
          const { data: chunks, error: rpcError } = await ctx.supabaseAdmin
            .rpc("match_document_chunks", {
              query_embedding: vectorStr,
              match_threshold: 0.3,
              match_count: 5,
              p_company_id: companyId
            });
          vectorSearchLatencyMs = Math.round(performance.now() - vectorSearchStartedAt);

          if (rpcError) {
            console.error("Vector similarity RPC failed:", rpcError);
          } else {
            contextChunks = chunks || [];
          }
        }
      }

      // ── Build retrieval evidence for context logging ──
      const retrievedDocumentIds = [
        ...new Set(contextChunks.map((c: any) => c.document_id).filter(Boolean))
      ];
      const retrievedChunks = contextChunks.map((c: any) => ({
        chunk_id: c.id,
        document_id: c.document_id,
        chunk_text: c.chunk_text?.substring(0, 500) // Truncate for storage efficiency
      }));
      const retrievalSimilarity = contextChunks.map((c: any) => ({
        chunk_id: c.id,
        similarity: c.similarity
      }));
      const retrievedChunkCount = contextChunks.length;

      // ── Context sources for debugging ──
      const contextSources: Array<{ source: string; rows: number }> = [];
      if (retrievedChunkCount > 0) {
        contextSources.push({
          source: "document_chunks",
          rows: retrievedChunkCount
        });
      }
      if (Object.keys(operationalContext).length > 0) {
        contextSources.push({
          source: "context_builder",
          rows: 1 // Single aggregated summary
        });
      }

      // 5. Retrieve or create conversation
      let activeConversationId = conversationId;
      const history: any[] = [];
      let isNewConversation = false;

      if (activeConversationId) {
        // Verify conversation belongs to user and fetch past messages
        const { data: convo } = await ctx.supabaseAdmin
          .from("ai_conversations")
          .select("*")
          .eq("id", activeConversationId)
          .eq("profile_id", userId)
          .maybeSingle();

        if (!convo) {
          activeConversationId = null;
        } else {
          // Fetch last 10 messages
          const { data: messages } = await ctx.supabaseAdmin
            .from("ai_messages")
            .select("*")
            .eq("conversation_id", activeConversationId)
            .order("created_at", { ascending: true })
            .limit(10);

          if (messages) {
            history.push(...messages);
          }
        }
      }

      if (!activeConversationId) {
        isNewConversation = true;
        const title = generateTitle(message);
        const { data: newConvo, error: convoError } = await ctx.supabaseAdmin
          .from("ai_conversations")
          .insert({
            company_id: companyId,
            profile_id: userId,
            title
          })
          .select()
          .single();

        if (convoError || !newConvo) {
          return errorResponse(`Failed to initialize conversation: ${convoError?.message}`);
        }
        activeConversationId = newConvo.id;
      }

      // 6. Query Gemini with structured Context and history
      const docText = contextChunks.length > 0
        ? contextChunks.map(c => c.chunk_text).join("\n\n")
        : "No relevant documents found.";

      // Use the Prompt Builder to fetch the active DB template or code fallback
      const promptData = await buildPrompt(
        ctx,
        companyId,
        routedSkill,
        operationalContext,
        docText
      );

      const systemInstruction = promptData.systemInstruction;
      const promptVersion = promptData.promptVersion;
      const schemaVersion = promptData.schemaVersion;

      let aiResponse = "";
      try {
        if (!genAI) {
          throw new Error("Gemini AI client not initialized. Check GEMINI_API_KEY in environment.");
        }

        const chatModel = genAI.getGenerativeModel({
          model: CHAT_MODEL,
          systemInstruction,
          generationConfig: {
            responseMimeType: "application/json",
            responseSchema: promptData.responseSchema
          }
        });

        const chatHistory = history.map(msg => ({
          role: msg.role === "user" ? "user" : "model",
          parts: [{ text: msg.content }]
        }));

        chatHistory.push({
          role: "user",
          parts: [{ text: message }]
        });

        const generationStartedAt = performance.now();
        const response = await chatModel.generateContent({
          contents: chatHistory
        });
        generationLatencyMs = Math.round(performance.now() - generationStartedAt);

        const generatedResponse = response.response as any;
        usageMetadata = generatedResponse.usageMetadata || {};
        aiResponse = generatedResponse.text() || "{}";
      } catch (geminiErr: any) {
        console.error("Gemini Content Generation failed:", geminiErr);

        const totalLatencyMs = Math.round(performance.now() - requestStartedAt);

        // Log failed attempt to usage logs
        await ctx.supabaseAdmin
          .from("ai_usage_logs")
          .insert({
            company_id: companyId,
            profile_id: userId,
            conversation_id: activeConversationId,
            provider: "gemini",
            model: CHAT_MODEL,
            operation: "rag_chat",
            prompt_tokens: 0,
            completion_tokens: 0,
            total_tokens: 0,
            latency_ms: totalLatencyMs,
            cost_usd: null,
            metadata: {
              status: "failed",
              error: geminiErr.message,
              ai_version: AI_VERSION,
              embeddingModel: EMBEDDING_MODEL,
              embeddingLatencyMs,
              vectorSearchLatencyMs,
              generationLatencyMs,
              contextChunkCount: retrievedChunkCount
            }
          });

        // Log failed context for debugging
        await ctx.supabaseAdmin
          .from("ai_context_logs")
          .insert({
            company_id: companyId,
            conversation_id: activeConversationId,
            question: message,
            skill: routedSkill,
            skill_confidence: routedConfidence,
            routing_reason: routingReason,
            retrieved_document_ids: retrievedDocumentIds,
            retrieved_chunks: retrievedChunks,
            retrieval_similarity: retrievalSimilarity,
            retrieved_chunk_count: retrievedChunkCount,
            context_snapshot: contextSnapshot,
            context_sources: contextSources,
            system_prompt: systemInstruction,
            full_prompt_hash: await sha256(systemInstruction + message),
            prompt_version: promptVersion,
            response_schema_version: schemaVersion,
            response: `[FAILED] ${geminiErr.message}`,
            response_sources: [],
            confidence: null,
            ai_version: AI_VERSION,
            total_latency_ms: totalLatencyMs,
            retrieval_latency_ms: vectorSearchLatencyMs,
            context_latency_ms: contextLatencyMs,
            gemini_latency_ms: generationLatencyMs
          });

        return errorResponse(`Failed to generate response via Gemini: ${geminiErr.message}`);
      }

      // 6. Save messages to database — normalized roles
      // Save User Message
      await ctx.supabaseAdmin
        .from("ai_messages")
        .insert({
          conversation_id: activeConversationId,
          role: "user", // Already correct
          content: message
        });

      // Process Gemini Response to validate contract and calculate deterministic confidence
      const processed = processGeminiResponse(aiResponse, routedSkill, {
        routingConfidence: routedConfidence,
        retrievedChunkCount,
        operationalContextSourcesCount: Object.keys(operationalContext).length,
        retrievedDocumentIds
      });

      // Save Model Response — normalize 'model' → 'assistant'
      const { data: savedAiMsg } = await ctx.supabaseAdmin
        .from("ai_messages")
        .insert({
          conversation_id: activeConversationId,
          role: "assistant", // Normalized from Gemini's 'model'
          content: processed.finalResponseText
        })
        .select()
        .single();

      // F3D: Insert Recommendations Engine
      const actions = processed.parsedResponse.recommended_actions || [];
      if (actions.length > 0) {
        // AI recommended actions usually don't have predefined priorities. We map them as Medium by default
        // unless specified in the text. To keep it simple, we insert them as 'Medium'.
        const recsToInsert = actions.map((act: string) => ({
          company_id: companyId,
          profile_id: userProfile.id,
          skill: routedSkill,
          priority: 'Medium', // AI generated actions fallback
          title: act.substring(0, 50) + (act.length > 50 ? '...' : ''),
          description: act,
          status: 'pending',
          recommendation_source: 'ai_generated',
          source_reference: {
            conversation_id: activeConversationId,
            message_id: savedAiMsg?.id,
            ai_version: AI_VERSION
          }
        }));
        
        await ctx.supabaseAdmin.from('ai_recommendations').insert(recsToInsert);
      }

      // 7. Update conversation's updated_at timestamp
      await ctx.supabaseAdmin
        .from("ai_conversations")
        .update({ updated_at: new Date().toISOString() })
        .eq("id", activeConversationId);

      // 8. Log usage metrics
      const promptTokens = toNonNegativeInteger(usageMetadata.promptTokenCount);
      const completionTokens = toNonNegativeInteger(usageMetadata.candidatesTokenCount);
      const totalTokens = toNonNegativeInteger(
        usageMetadata.totalTokenCount ?? promptTokens + completionTokens
      );
      const costUsd = estimateCostUsd(promptTokens, completionTokens);
      const totalLatencyMs = Math.round(performance.now() - requestStartedAt);

      const { error: usageLogError } = await ctx.supabaseAdmin
        .from("ai_usage_logs")
        .insert({
          company_id: companyId,
          profile_id: userId,
          conversation_id: activeConversationId,
          message_id: savedAiMsg?.id ?? null,
          provider: "gemini",
          model: CHAT_MODEL,
          operation: "rag_chat",
          prompt_tokens: promptTokens,
          completion_tokens: completionTokens,
          total_tokens: totalTokens,
          latency_ms: totalLatencyMs,
          cost_usd: costUsd,
          metadata: {
            status: "succeeded",
            ai_version: AI_VERSION,
            embeddingModel: EMBEDDING_MODEL,
            embeddingLatencyMs,
            vectorSearchLatencyMs,
            generationLatencyMs,
            contextChunkCount: retrievedChunkCount
          }
        });

      if (usageLogError) {
        console.error(`Failed to log AI usage: ${usageLogError.message}`);
      }

      // 9. Log context evidence — the forensic debugging record
      const promptHash = await sha256(systemInstruction + message);

      const { error: contextLogError } = await ctx.supabaseAdmin
        .from("ai_context_logs")
        .insert({
          company_id: companyId,
          conversation_id: activeConversationId,
          message_id: savedAiMsg?.id ?? null,
          question: message,
          skill: routedSkill,
          skill_confidence: routedConfidence,
          routing_reason: routingReason,
          // RAG retrieval evidence
          retrieved_document_ids: retrievedDocumentIds,
          retrieved_chunks: retrievedChunks,
          retrieval_similarity: retrievalSimilarity,
          retrieved_chunk_count: retrievedChunkCount,
          // Operational context
          context_snapshot: contextSnapshot,
          context_sources: contextSources,
          compliance_snapshot_id: null,
          // Prompt assembly
          system_prompt: systemInstruction,
          full_prompt_hash: promptHash,
          prompt_version: promptVersion,
          response_schema_version: schemaVersion,
          // Response
          response: processed.finalResponseText,
          response_sources: processed.responseSources,
          confidence: processed.finalConfidence,
          // Pipeline metadata
          ai_version: AI_VERSION,
          total_latency_ms: totalLatencyMs,
          retrieval_latency_ms: vectorSearchLatencyMs,
          context_latency_ms: contextLatencyMs,
          gemini_latency_ms: generationLatencyMs
        });

      if (contextLogError) {
        console.error(`Failed to log AI context: ${contextLogError.message}`);
      }

      return successResponse({
        response: processed.parsedResponse, // Returning the structured JSON instead of string
        conversationId: activeConversationId,
        messageId: savedAiMsg?.id
      }, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
