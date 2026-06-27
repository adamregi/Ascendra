import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const GROWTH_OPPORTUNITY_VERSION = "f7-v1";

export interface GrowthOpportunityResponse extends BaseAIResponse {
  key_improvers: string[];
  top_performers: string[];
}

export const GROWTH_OPPORTUNITY_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    key_improvers: { type: "array", items: { type: "string" } },
    top_performers: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "key_improvers", "top_performers", "recommended_actions", "confidence"]
};

export const GROWTH_OPPORTUNITY_FALLBACK_PROMPT = `You are Ascendra Growth Opportunity Analyzer.

Objectives:
1. Review the provided growth analytics and top performers data.
2. Identify members showing the strongest positive trends in attendance and task completion over the last 30 days.
3. Highlight consistent top performers.
4. Output actionable recommendations for the leader to foster continued growth.

Response Rules:
- Only reference members in the context payload.
- Focus on positive reinforcement and talent discovery.`;

export function validateGrowthOpportunityResponse(data: any): GrowthOpportunityResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    key_improvers: Array.isArray(data?.key_improvers) ? data.key_improvers : [],
    top_performers: Array.isArray(data?.top_performers) ? data.top_performers : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const growthOpportunityFallback: PromptTemplate = {
  skill: "growth_opportunity",
  version: GROWTH_OPPORTUNITY_VERSION,
  systemPrompt: GROWTH_OPPORTUNITY_FALLBACK_PROMPT,
  responseSchema: GROWTH_OPPORTUNITY_SCHEMA,
  isFallback: true
};
