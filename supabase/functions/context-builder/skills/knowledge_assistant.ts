import { getGeminiModel } from "../../_shared/clients/gemini.ts";

export async function buildKnowledgeAssistantContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    // 1. Generate Embedding for the query
    const embedModel = getGeminiModel("text-embedding-004");
    const embedResult = await embedModel.embedContent(question);
    const values = embedResult.embedding?.values;

    if (!values || values.length === 0) {
      console.warn("Gemini returned empty embedding for search query.");
    }
    const vectorStr = `[${(values || new Array(768).fill(0)).join(",")}]`;

    // 2. Call Hybrid Search RPC
    const { data: chunks, error } = await supabaseAdmin.rpc('search_knowledge_hybrid', {
      p_company_id: companyId,
      p_query: question,
      p_embedding: vectorStr,
      p_match_count: 10
    });

    if (error) {
      console.error("Hybrid search failed:", error);
      return { error: "Failed to retrieve knowledge base context." };
    }

    if (!chunks || chunks.length === 0) {
      return {
        documents_found: 0,
        sources: []
      };
    }

    // 3. Group by source_type and build response
    const groupedSources: Record<string, any> = {};

    for (const chunk of chunks) {
      const sourceKey = `${chunk.source_type}:${chunk.source_id}`;
      if (!groupedSources[sourceKey]) {
        groupedSources[sourceKey] = {
          type: chunk.source_type || 'document',
          id: chunk.source_id,
          title: chunk.title,
          category: chunk.category,
          chunks: []
        };
      }
      
      groupedSources[sourceKey].chunks.push({
        text: chunk.chunk_text,
        relevance_score: chunk.combined_score
      });
    }

    return {
      documents_found: Object.keys(groupedSources).length,
      retrieved_chunk_count: chunks.length,
      sources: Object.values(groupedSources)
    };

  } catch (err: any) {
    console.error("Error in knowledge assistant context builder:", err);
    return { error: "Failed to build knowledge context." };
  }
}
