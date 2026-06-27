import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";
import { getGeminiModel } from "../_shared/clients/gemini.ts";

function chunkText(text: string, chunkSize = 1000, overlap = 200): string[] {
  if (!text) return [];
  const chunks: string[] = [];
  let i = 0;
  while (i < text.length) {
    chunks.push(text.substring(i, i + chunkSize));
    if (i + chunkSize >= text.length) break;
    i += chunkSize - overlap;
  }
  return chunks;
}

export default {
  // Can be called by upload-document (secret auth) or directly by database webhooks
  fetch: withSupabase({ auth: ["secret", "user", "publishable"] }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const body = await req.json();
      
      // Support database webhook structure (body.record) as well as direct api call (body.documentId)
      let documentId = body.documentId;
      let rawText = "";

      if (body.record && !documentId) {
        documentId = body.record.id;
        rawText = body.record.raw_text;
      }

      if (!documentId) {
        return errorResponse("Missing required field: documentId");
      }

      // Fetch document details if we don't have the text from the webhook record
      if (!rawText) {
        const { data: document, error: docError } = await ctx.supabaseAdmin
          .from("documents")
          .select("raw_text")
          .eq("id", documentId)
          .single();

        if (docError || !document) {
          return errorResponse(`Could not find document ${documentId}: ${docError?.message || "Not found"}`, 404);
        }
        rawText = document.raw_text || "";
      }

      if (!rawText.trim()) {
        return successResponse({
          message: "Document raw text is empty. No chunks or embeddings generated.",
          chunksCount: 0
        }, 200);
      }

      // 1. Chunk the text
      const chunks = chunkText(rawText);
      const chunksCount = chunks.length;

      // 2. Clear out any existing chunks for this document to prevent duplicate embeddings on reprocessing
      await ctx.supabaseAdmin
        .from("document_chunks")
        .delete()
        .eq("document_id", documentId);

      // 3. Generate embeddings and save chunks
      const embedModel = getGeminiModel("text-embedding-004");

      for (let idx = 0; idx < chunks.length; idx++) {
        const chunk = chunks[idx];
        
        try {
          // Generate vector embedding using Gemini text-embedding-004
          const embedResult = await embedModel.embedContent(chunk);
          const values = embedResult.embedding?.values;

          if (!values || values.length === 0) {
            throw new Error(`Gemini returned empty embedding for chunk ${idx}`);
          }

          // Format embedding as pgvector bracketed string, e.g. '[0.1,0.2,...]'
          const vectorStr = `[${values.join(",")}]`;

          // Insert into document_chunks
          const { error: insertError } = await ctx.supabaseAdmin
            .from("document_chunks")
            .insert({
              document_id: documentId,
              chunk_text: chunk,
              embedding: vectorStr
            });

          if (insertError) {
            console.error(`Failed to insert chunk ${idx} for document ${documentId}: ${insertError.message}`);
          }
        } catch (embedErr: any) {
          console.error(`Failed to generate embedding for chunk ${idx} of document ${documentId}:`, embedErr);
          // Continue with other chunks rather than failing the whole function, or throw depending on tolerance
        }
      }

      return successResponse({
        message: "Embeddings generated and stored successfully",
        documentId,
        chunksCount
      }, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
