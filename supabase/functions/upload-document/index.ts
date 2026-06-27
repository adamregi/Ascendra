import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";
import { getGeminiModel } from "../_shared/clients/gemini.ts";
import JSZip from "jszip";

// Safe Base64 encoder for large TypedArrays
function uint8ArrayToBase64(bytes: Uint8Array): string {
  const chunks: string[] = [];
  const chunkSize = 0x8000; // 32KB
  for (let i = 0; i < bytes.length; i += chunkSize) {
    chunks.push(String.fromCharCode.apply(null, bytes.subarray(i, i + chunkSize) as any));
  }
  return btoa(chunks.join(""));
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

      const formData = await req.formData();
      const file = formData.get("file") as File;
      const companyId = formData.get("companyId") as string;

      if (!file || !companyId) {
        return errorResponse("Missing required fields: file, companyId");
      }

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      const fileBytes = new Uint8Array(await file.arrayBuffer());
      let extractedText = "";

      // 1. Extract text based on file format
      const mimeType = file.type || "";
      const fileName = file.name.toLowerCase();

      if (mimeType === "text/plain" || fileName.endsWith(".txt")) {
        extractedText = new TextDecoder().decode(fileBytes);
      } else if (mimeType === "application/pdf" || fileName.endsWith(".pdf")) {
        // Use Gemini 1.5 Flash to extract text from PDF
        try {
          const model = getGeminiModel("gemini-1.5-flash");
          const base64Data = uint8ArrayToBase64(fileBytes);
          const response = await model.generateContent([
            {
              inlineData: {
                data: base64Data,
                mimeType: "application/pdf"
              }
            },
            "Extract all readable text from this PDF document. Return ONLY the extracted text, with no introduction, explanation, formatting, or extra commentary."
          ]);
          extractedText = response.response.text() || "";
        } catch (geminiErr: any) {
          console.error("Gemini PDF extraction failed:", geminiErr);
          return errorResponse(`Failed to extract text from PDF via Gemini: ${geminiErr.message}`);
        }
      } else if (
        mimeType === "application/vnd.openxmlformats-officedocument.wordprocessingml.document" ||
        fileName.endsWith(".docx")
      ) {
        // Parse DOCX via JSZip
        try {
          const zip = await JSZip.loadAsync(fileBytes.buffer);
          const docXml = await zip.file("word/document.xml")?.async("text");
          if (!docXml) {
            throw new Error("word/document.xml not found in DOCX file zip archive.");
          }
          const matches = docXml.match(/<w:t[^>]*>(.*?)<\/w:t>/g);
          extractedText = matches
            ? matches.map((val) => val.replace(/<w:t[^>]*>|<\/w:t>/g, "")).join(" ")
            : "";
        } catch (zipErr: any) {
          console.error("DOCX extraction failed:", zipErr);
          return errorResponse(`Failed to parse DOCX file: ${zipErr.message}`);
        }
      } else {
        return errorResponse(`Unsupported file type: ${mimeType || "unknown"}. Supported types are: PDF, DOCX, TXT.`);
      }

      // 2. Ensure Storage bucket exists and upload original file
      // createBucket returns a warning if it already exists, so we just run it safely
      await ctx.supabaseAdmin.storage.createBucket("documents", {
        public: false
      });

      const storagePath = `${companyId}/${crypto.randomUUID()}_${file.name}`;
      const { error: uploadError } = await ctx.supabaseAdmin.storage
        .from("documents")
        .upload(storagePath, fileBytes, {
          contentType: mimeType || "application/octet-stream",
          upsert: true
        });

      if (uploadError) {
        return errorResponse(`Failed to upload file to storage: ${uploadError.message}`);
      }

      // 3. Save Document details to DB
      const { data: document, error: docError } = await ctx.supabaseAdmin
        .from("documents")
        .insert({
          company_id: companyId,
          uploaded_by: userId,
          file_name: file.name,
          storage_path: storagePath,
          mime_type: mimeType || "application/octet-stream",
          raw_text: extractedText
        })
        .select()
        .single();

      if (docError) {
        return errorResponse(`Failed to save document record: ${docError.message}`);
      }

      // 4. Trigger generate-embeddings asynchronously
      const supabaseUrl = Deno.env.get("SUPABASE_URL");
      const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

      if (supabaseUrl && serviceKey && document) {
        const functionUrl = `${supabaseUrl}/functions/v1/generate-embeddings`;
        fetch(functionUrl, {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${serviceKey}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ documentId: document.id })
        }).catch(err => {
          console.error("Asynchronous trigger of generate-embeddings failed:", err);
        });
      }

      return successResponse({
        message: "Document uploaded and parsed successfully",
        document
      }, 201);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
