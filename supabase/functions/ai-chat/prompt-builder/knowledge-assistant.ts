import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const KNOWLEDGE_ASSISTANT_VERSION = "f4-v1";

export interface KnowledgeAssistantResponse extends BaseAIResponse {
  key_points: string[];
  related_products: string[];
  related_documents: string[];
  sources: {
    type: string;
    title: string;
  }[];
}

export const KNOWLEDGE_ASSISTANT_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    key_points: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    related_products: { type: "array", items: { type: "string" } },
    related_documents: { type: "array", items: { type: "string" } },
    confidence: { type: "number" },
    sources: {
      type: "array",
      items: {
        type: "object",
        properties: {
          type: { type: "string" },
          title: { type: "string" }
        },
        required: ["type", "title"]
      }
    }
  },
  required: ["summary", "key_points", "recommended_actions", "related_products", "related_documents", "confidence", "sources"]
};

export const KNOWLEDGE_ASSISTANT_FALLBACK_PROMPT = `You are Ascendra Knowledge Assistant.

Objectives:
1. Answer questions based purely on the provided hybrid-search context (documents, products, faqs, success_stories).
2. Distill the information into clear key points.
3. Recommend actions based on the information.
4. Cite the EXACT source type and title in the "sources" array.

Response Rules:
- Do not hallucinate products or policies that are not in the context.
- Keep the summary concise.`;

export function validateKnowledgeAssistantResponse(data: any): KnowledgeAssistantResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    key_points: Array.isArray(data?.key_points) ? data.key_points : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    related_products: Array.isArray(data?.related_products) ? data.related_products : [],
    related_documents: Array.isArray(data?.related_documents) ? data.related_documents : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5,
    sources: Array.isArray(data?.sources) ? data.sources : []
  };
}

export const knowledgeAssistantFallback: PromptTemplate = {
  skill: "knowledge_assistant",
  version: KNOWLEDGE_ASSISTANT_VERSION,
  systemPrompt: KNOWLEDGE_ASSISTANT_FALLBACK_PROMPT,
  responseSchema: KNOWLEDGE_ASSISTANT_SCHEMA,
  isFallback: true
};
