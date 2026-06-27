import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";
import { getSkillContract } from "./skills/registry.ts";

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

export default {
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { companyId, profileId, skill, question } = await req.json();

      if (!companyId || !profileId || !skill || !question) {
        return errorResponse("Missing required fields: companyId, profileId, skill, question");
      }

      // 1. Normalize question & Hash
      const normalizedQuestion = question.toLowerCase().trim().replace(/\s+/g, ' ').replace(/[^\w\s]/gi, '');
      const questionHash = await sha256(normalizedQuestion);

      // 2. Cache Lookup
      const { data: cacheHit } = await ctx.supabaseAdmin
        .from("context_cache")
        .select("payload, expires_at")
        .eq("company_id", companyId)
        .eq("profile_id", profileId)
        .eq("skill", skill)
        .eq("question_hash", questionHash)
        .gt("expires_at", new Date().toISOString())
        .maybeSingle();

      if (cacheHit && cacheHit.payload) {
        return successResponse({
            ...cacheHit.payload,
            metadata: {
                ...cacheHit.payload.metadata,
                cache_hit: true,
                cache_age_seconds: Math.round((Date.now() - new Date(cacheHit.payload.metadata.generated_at).getTime()) / 1000)
            }
        }, 200);
      }

      // 3. Invoke Modular Contract
      const buildContext = await getSkillContract(skill);
      if (!buildContext) {
          return errorResponse(`No context contract found for skill: ${skill}`, 400);
      }

      const contextData = await buildContext(ctx.supabaseAdmin, companyId, profileId, question);

      // Early return if clarification is needed
      if (contextData.needs_clarification) {
         return successResponse(contextData, 200);
      }

      // 4. Validate & Token Limit (Cap at 16,000 chars roughly)
      const stringifiedData = JSON.stringify(contextData);
      let finalContext = contextData;
      if (stringifiedData.length > 16000) {
        // Fallback truncation strategy (in reality, individual contracts should limit to 10 items)
        finalContext = {
             truncated: true,
             note: "Context exceeded budget. Please ask a more specific question."
        };
      }

      const payload = {
        context: finalContext,
        metadata: {
          schema_version: "f1-context",
          generated_at: new Date().toISOString(),
          cache_hit: false,
          cache_age_seconds: 0
        }
      };

      // 5. Cache Upsert (TTL: 5 minutes)
      const expiresAt = new Date(Date.now() + 5 * 60 * 1000).toISOString();
      await ctx.supabaseAdmin
        .from("context_cache")
        .upsert({
          company_id: companyId,
          profile_id: profileId,
          skill: skill,
          question_hash: questionHash,
          payload: payload,
          expires_at: expiresAt
        });

      return successResponse(payload, 200);

    } catch (err: any) {
      console.error("Context Builder error:", err);
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
