import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const GROWTH_OPPORTUNITY_VERSION = "f2-v1";

export interface GrowthOpportunityResponse extends BaseAIResponse {
  growth_candidates: string[];
  expansion_opportunities: string[];
}

export const GROWTH_OPPORTUNITY_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    growth_candidates: { type: "array", items: { type: "string" } },
    expansion_opportunities: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "growth_candidates", "recommended_actions", "confidence"]
};

export const GROWTH_OPPORTUNITY_FALLBACK_PROMPT = `You are Ascendra Growth Opportunity Analyzer.

Objectives:
1. Identify candidates for promotion.
2. Recommend expansion steps.`;

export function validateGrowthOpportunityResponse(data: any): GrowthOpportunityResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    growth_candidates: Array.isArray(data?.growth_candidates) ? data.growth_candidates : [],
    expansion_opportunities: Array.isArray(data?.expansion_opportunities) ? data.expansion_opportunities : [],
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
