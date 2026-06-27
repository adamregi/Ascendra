import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const MEETING_COACH_VERSION = "f5b-v1";

export interface MeetingCoachResponse extends BaseAIResponse {
  key_points: string[];
}

export const MEETING_COACH_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    key_points: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "key_points", "recommended_actions", "confidence"]
};

export const MEETING_COACH_FALLBACK_PROMPT = `You are Ascendra Meeting Coach.

Objectives:
1. Review the provided analytics regarding team attendance rates and members needing coaching.
2. Distill the information into clear key points (e.g., who is missing the most meetings).
3. Recommend specific actions for the leader (e.g., Follow up with John regarding 3 missed meetings).

Response Rules:
- Do not hallucinate members not present in the context.
- Be concise and actionable.
- Identify at-risk individuals based strictly on their 30-day and 7-day attendance.`;

export function validateMeetingCoachResponse(data: any): MeetingCoachResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    key_points: Array.isArray(data?.key_points) ? data.key_points : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const meetingCoachFallback: PromptTemplate = {
  skill: "meeting_coach",
  version: MEETING_COACH_VERSION,
  systemPrompt: MEETING_COACH_FALLBACK_PROMPT,
  responseSchema: MEETING_COACH_SCHEMA,
  isFallback: true
};
