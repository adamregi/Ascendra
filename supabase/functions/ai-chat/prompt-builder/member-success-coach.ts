import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const MEMBER_SUCCESS_COACH_VERSION = "f6-v1";

export interface MemberSuccessCoachResponse extends BaseAIResponse {
  current_status: string;
  strengths: string[];
  weaknesses: string[];
  risk_factors: string[];
  improvement_plan_30_days: string[];
}

export const MEMBER_SUCCESS_COACH_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    current_status: { type: "string" },
    strengths: { type: "array", items: { type: "string" } },
    weaknesses: { type: "array", items: { type: "string" } },
    risk_factors: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    improvement_plan_30_days: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "current_status", "strengths", "weaknesses", "risk_factors", "recommended_actions", "improvement_plan_30_days", "confidence"]
};

export const MEMBER_SUCCESS_COACH_FALLBACK_PROMPT = `You are Ascendra Member Success Coach.

Objectives:
1. Review the member analytics, risk scores, and insights for the target member.
2. Determine their current status, key strengths, and specific weaknesses/risk factors.
3. Formulate coaching recommendations.
4. Output a clear 30-Day Improvement Plan.

Response Rules:
- Only reference the member in the context payload.
- Output the improvement plan as an array of structured action steps.`;

export function validateMemberSuccessCoachResponse(data: any): MemberSuccessCoachResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    current_status: typeof data?.current_status === "string" ? data.current_status : "Unknown",
    strengths: Array.isArray(data?.strengths) ? data.strengths : [],
    weaknesses: Array.isArray(data?.weaknesses) ? data.weaknesses : [],
    risk_factors: Array.isArray(data?.risk_factors) ? data.risk_factors : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    improvement_plan_30_days: Array.isArray(data?.improvement_plan_30_days) ? data.improvement_plan_30_days : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const memberSuccessCoachFallback: PromptTemplate = {
  skill: "member_success",
  version: MEMBER_SUCCESS_COACH_VERSION,
  systemPrompt: MEMBER_SUCCESS_COACH_FALLBACK_PROMPT,
  responseSchema: MEMBER_SUCCESS_COACH_SCHEMA,
  isFallback: true
};
