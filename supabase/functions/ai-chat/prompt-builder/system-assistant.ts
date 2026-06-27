import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const SYSTEM_ASSISTANT_VERSION = "f2-v1";

export interface SystemAssistantResponse extends BaseAIResponse {
  action_steps: string[];
  feature_check: string;
}

export const SYSTEM_ASSISTANT_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    action_steps: { type: "array", items: { type: "string" } },
    feature_check: { type: "string" },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "recommended_actions", "confidence"]
};

export const SYSTEM_ASSISTANT_FALLBACK_PROMPT = `You are Ascendra System Assistant.

Objectives:
1. Guide users on how to use the platform.
2. Explain feature availability.`;

export function validateSystemAssistantResponse(data: any): SystemAssistantResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    action_steps: Array.isArray(data?.action_steps) ? data.action_steps : [],
    feature_check: typeof data?.feature_check === "string" ? data.feature_check : "",
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const systemAssistantFallback: PromptTemplate = {
  skill: "system_assistant",
  version: SYSTEM_ASSISTANT_VERSION,
  systemPrompt: SYSTEM_ASSISTANT_FALLBACK_PROMPT,
  responseSchema: SYSTEM_ASSISTANT_SCHEMA,
  isFallback: true
};
