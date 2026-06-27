import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const RECOGNITION_COACH_VERSION = "f7-v1";

export interface RecognitionCoachResponse extends BaseAIResponse {
  achievements: string[];
  suggested_recognitions: string[];
}

export const RECOGNITION_COACH_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    achievements: { type: "array", items: { type: "string" } },
    suggested_recognitions: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "achievements", "suggested_recognitions", "recommended_actions", "confidence"]
};

export const RECOGNITION_COACH_FALLBACK_PROMPT = `You are Ascendra Recognition Coach.

Objectives:
1. Review the provided recent leadership milestones and recognitions.
2. Identify members who have achieved significant milestones but haven't received a leader recognition yet.
3. Highlight team achievements.
4. Output actionable recommendations on who to recognize and why.

Response Rules:
- Only reference members in the context payload.
- Focus strictly on positive reinforcement and engagement.`;

export function validateRecognitionCoachResponse(data: any): RecognitionCoachResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    achievements: Array.isArray(data?.achievements) ? data.achievements : [],
    suggested_recognitions: Array.isArray(data?.suggested_recognitions) ? data.suggested_recognitions : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const recognitionCoachFallback: PromptTemplate = {
  skill: "recognition_coach",
  version: RECOGNITION_COACH_VERSION,
  systemPrompt: RECOGNITION_COACH_FALLBACK_PROMPT,
  responseSchema: RECOGNITION_COACH_SCHEMA,
  isFallback: true
};
