import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const MEMBER_SUCCESS_VERSION = "f2-v1";

export interface MemberSuccessResponse extends BaseAIResponse {
  strengths: string[];
  weaknesses: string[];
  improvement_plan: string[];
}

export const MEMBER_SUCCESS_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    strengths: { type: "array", items: { type: "string" } },
    weaknesses: { type: "array", items: { type: "string" } },
    improvement_plan: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "recommended_actions", "confidence"]
};

export const MEMBER_SUCCESS_FALLBACK_PROMPT = `You are Ascendra Member Success Coach.

Objectives:
1. Assess member status.
2. Highlight strengths.
3. Provide an improvement plan.`;

export function validateMemberSuccessResponse(data: any): MemberSuccessResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    strengths: Array.isArray(data?.strengths) ? data.strengths : [],
    weaknesses: Array.isArray(data?.weaknesses) ? data.weaknesses : [],
    improvement_plan: Array.isArray(data?.improvement_plan) ? data.improvement_plan : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const memberSuccessFallback: PromptTemplate = {
  skill: "member_success",
  version: MEMBER_SUCCESS_VERSION,
  systemPrompt: MEMBER_SUCCESS_FALLBACK_PROMPT,
  responseSchema: MEMBER_SUCCESS_SCHEMA,
  isFallback: true
};
