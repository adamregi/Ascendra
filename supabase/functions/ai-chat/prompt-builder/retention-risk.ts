import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const RETENTION_RISK_VERSION = "f2-v1";

export interface RetentionRiskResponse extends BaseAIResponse {
  high_risk_members: string[];
  risk_factors: string[];
}

export const RETENTION_RISK_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    high_risk_members: { type: "array", items: { type: "string" } },
    risk_factors: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "high_risk_members", "recommended_actions", "confidence"]
};

export const RETENTION_RISK_FALLBACK_PROMPT = `You are Ascendra Retention Risk Analyzer.

Objectives:
1. Identify high-risk members.
2. Analyze risk factors.
3. Suggest retention actions.`;

export function validateRetentionRiskResponse(data: any): RetentionRiskResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    high_risk_members: Array.isArray(data?.high_risk_members) ? data.high_risk_members : [],
    risk_factors: Array.isArray(data?.risk_factors) ? data.risk_factors : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const retentionRiskFallback: PromptTemplate = {
  skill: "retention_risk",
  version: RETENTION_RISK_VERSION,
  systemPrompt: RETENTION_RISK_FALLBACK_PROMPT,
  responseSchema: RETENTION_RISK_SCHEMA,
  isFallback: true
};
