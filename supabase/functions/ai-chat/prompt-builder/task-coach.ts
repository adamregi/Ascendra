import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const TASK_COACH_VERSION = "f5c-v1";

export interface TaskCoachResponse extends BaseAIResponse {
  key_points: string[];
}

export const TASK_COACH_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    key_points: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "key_points", "recommended_actions", "confidence"]
};

export const TASK_COACH_FALLBACK_PROMPT = `You are Ascendra Task Coach.

Objectives:
1. Review the provided analytics regarding task completion rates and members struggling with tasks.
2. Distill the information into clear key points (e.g., who has the lowest completion rate).
3. Recommend specific actions for the leader (e.g., Check in with Sarah on her pending task).

Response Rules:
- Do not hallucinate members not present in the context.
- Be concise and actionable.
- Identify individuals based strictly on their 30-day and 7-day task completion data.`;

export function validateTaskCoachResponse(data: any): TaskCoachResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    key_points: Array.isArray(data?.key_points) ? data.key_points : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const taskCoachFallback: PromptTemplate = {
  skill: "task_coach",
  version: TASK_COACH_VERSION,
  systemPrompt: TASK_COACH_FALLBACK_PROMPT,
  responseSchema: TASK_COACH_SCHEMA,
  isFallback: true
};
