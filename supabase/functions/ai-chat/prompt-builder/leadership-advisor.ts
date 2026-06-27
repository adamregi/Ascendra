import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const LEADERSHIP_ADVISOR_VERSION = "f6-v1";

export interface LeadershipAdvisorResponse extends BaseAIResponse {
  key_findings: string[];
  risks: string[];
  opportunities: string[];
}

export const LEADERSHIP_ADVISOR_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    key_findings: { type: "array", items: { type: "string" } },
    risks: { type: "array", items: { type: "string" } },
    opportunities: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "key_findings", "risks", "opportunities", "recommended_actions", "confidence"]
};

export const LEADERSHIP_ADVISOR_FALLBACK_PROMPT = `You are Ascendra Leadership Advisor.

Objectives:
1. Review the team analytics, member risk scores, and existing coach insights/recommendations.
2. Formulate a comprehensive executive summary of the team's health.
3. Identify top risks and growth opportunities without duplicating already-completed insights.
4. Output specific, actionable recommended actions.

Response Rules:
- Only reference members in the provided context payload.
- Separate risks and opportunities distinctly.
- Recommendations must be actionable.`;

export function validateLeadershipAdvisorResponse(data: any): LeadershipAdvisorResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    key_findings: Array.isArray(data?.key_findings) ? data.key_findings : [],
    risks: Array.isArray(data?.risks) ? data.risks : [],
    opportunities: Array.isArray(data?.opportunities) ? data.opportunities : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const leadershipAdvisorFallback: PromptTemplate = {
  skill: "leadership_advisor",
  version: LEADERSHIP_ADVISOR_VERSION,
  systemPrompt: LEADERSHIP_ADVISOR_FALLBACK_PROMPT,
  responseSchema: LEADERSHIP_ADVISOR_SCHEMA,
  isFallback: true
};
