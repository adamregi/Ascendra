import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const PROMOTION_ADVISOR_VERSION = "f7-v1";

export interface PromotionAdvisorResponse extends BaseAIResponse {
  top_candidates: string[];
  recommendation_reasons: string[];
}

export const PROMOTION_ADVISOR_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    top_candidates: { type: "array", items: { type: "string" } },
    recommendation_reasons: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "top_candidates", "recommendation_reasons", "recommended_actions", "confidence"]
};

export const PROMOTION_ADVISOR_FALLBACK_PROMPT = `You are Ascendra Promotion Advisor.

Objectives:
1. Review the provided promotion candidates and pending leadership recommendations.
2. Identify members in the Future Leader or Emerging Leader bands who sustain high performance.
3. Validate and summarize AI-generated promotion recommendations.
4. Output actionable advice for the leader on next steps for these candidates.

Response Rules:
- Only reference members in the context payload.
- Focus on leadership potential and sustained metrics.`;

export function validatePromotionAdvisorResponse(data: any): PromotionAdvisorResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    top_candidates: Array.isArray(data?.top_candidates) ? data.top_candidates : [],
    recommendation_reasons: Array.isArray(data?.recommendation_reasons) ? data.recommendation_reasons : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const promotionAdvisorFallback: PromptTemplate = {
  skill: "promotion_advisor",
  version: PROMOTION_ADVISOR_VERSION,
  systemPrompt: PROMOTION_ADVISOR_FALLBACK_PROMPT,
  responseSchema: PROMOTION_ADVISOR_SCHEMA,
  isFallback: true
};
