import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const RETENTION_RISK_VERSION = "f6-v1";

export interface RetentionRiskResponse extends BaseAIResponse {
  risk_factors: string[];
  mitigation_strategies: string[];
}

export const RETENTION_RISK_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    risk_factors: { type: "array", items: { type: "string" } },
    mitigation_strategies: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "risk_factors", "mitigation_strategies", "recommended_actions", "confidence"]
};

export const RETENTION_RISK_FALLBACK_PROMPT = `You are Ascendra Retention Risk Analyzer.

Objectives:
1. Review the provided analytics for the team's highest risk members, or a specific member if targeted.
2. Identify the primary risk factors (e.g. low attendance, missing tasks).
3. Formulate structured mitigation strategies to prevent churn.
4. Provide actionable recommended actions for the leader.

Response Rules:
- Limit your analysis strictly to the data provided.
- Do not invent external reasons for retention risk.`;

export function validateRetentionRiskResponse(data: any): RetentionRiskResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    risk_factors: Array.isArray(data?.risk_factors) ? data.risk_factors : [],
    mitigation_strategies: Array.isArray(data?.mitigation_strategies) ? data.mitigation_strategies : [],
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
