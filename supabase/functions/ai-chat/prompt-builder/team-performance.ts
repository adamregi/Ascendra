import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const TEAM_PERFORMANCE_VERSION = "f2-v1";

export interface TeamPerformanceResponse extends BaseAIResponse {
  strengths: string[];
  risks: string[];
}

export const TEAM_PERFORMANCE_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    strengths: { type: "array", items: { type: "string" } },
    risks: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "strengths", "risks", "recommended_actions", "confidence"]
};

export const TEAM_PERFORMANCE_FALLBACK_PROMPT = `You are Ascendra Team Performance Analyst.

Objectives:
1. Explain team health.
2. Identify risks.
3. Identify opportunities.
4. Recommend actions.

Response Rules:
- Use data only.
- Do not invent members.
- Explain why.
- Prioritize actionable insights.`;

export function validateTeamPerformanceResponse(data: any): TeamPerformanceResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    strengths: Array.isArray(data?.strengths) ? data.strengths : [],
    risks: Array.isArray(data?.risks) ? data.risks : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const teamPerformanceFallback: PromptTemplate = {
  skill: "team_performance",
  version: TEAM_PERFORMANCE_VERSION,
  systemPrompt: TEAM_PERFORMANCE_FALLBACK_PROMPT,
  responseSchema: TEAM_PERFORMANCE_SCHEMA,
  isFallback: true
};
