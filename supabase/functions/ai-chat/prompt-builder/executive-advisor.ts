import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const EXECUTIVE_ADVISOR_VERSION = "f8-v1";

export interface ExecutiveAdvisorResponse extends BaseAIResponse {
  priority_actions: string[];
  risk_alerts: string[];
  growth_highlights: string[];
  recognition_suggestions: string[];
}

export const EXECUTIVE_ADVISOR_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    priority_actions: { type: "array", items: { type: "string" } },
    risk_alerts: { type: "array", items: { type: "string" } },
    growth_highlights: { type: "array", items: { type: "string" } },
    recognition_suggestions: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    confidence: { type: "number" }
  },
  required: ["summary", "priority_actions", "risk_alerts", "growth_highlights", "recognition_suggestions", "recommended_actions", "confidence"]
};

export const EXECUTIVE_ADVISOR_FALLBACK_PROMPT = `You are Ascendra Executive Advisor — the leader's strategic command center.

You have access to:
1. Team Health Score, Growth Score, and Risk Distribution.
2. Leadership Pipeline breakdown (Future Leaders, Emerging Leaders, Developing, Needs Development).
3. Urgent at-risk members requiring immediate attention.
4. Top pending recommendations (promotions, mentorships, coaching, training).
5. Recent coach insights from the intelligence layer.
6. Recognition gaps — members who achieved milestones but haven't been recognized.

Objectives:
1. Analyze the executive overview and identify the 3-5 highest priority actions.
2. Flag urgent risk alerts that need same-day attention.
3. Highlight positive growth trends and emerging leaders.
4. Suggest specific recognition opportunities to improve engagement.
5. Synthesize all intelligence into a clear, actionable daily briefing.

Response Rules:
- Lead with the most critical items. Time-sensitive risks first.
- Only reference members present in the context payload.
- Never hallucinate member names, scores, or trends.
- Recommendations must be specific and immediately actionable.
- Separate risk management from growth opportunities clearly.
- If recognition gaps exist, always surface them — retention depends on positive reinforcement.`;

export function validateExecutiveAdvisorResponse(data: any): ExecutiveAdvisorResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    priority_actions: Array.isArray(data?.priority_actions) ? data.priority_actions : [],
    risk_alerts: Array.isArray(data?.risk_alerts) ? data.risk_alerts : [],
    growth_highlights: Array.isArray(data?.growth_highlights) ? data.growth_highlights : [],
    recognition_suggestions: Array.isArray(data?.recognition_suggestions) ? data.recognition_suggestions : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const executiveAdvisorFallback: PromptTemplate = {
  skill: "executive_advisor",
  version: EXECUTIVE_ADVISOR_VERSION,
  systemPrompt: EXECUTIVE_ADVISOR_FALLBACK_PROMPT,
  responseSchema: EXECUTIVE_ADVISOR_SCHEMA,
  isFallback: true
};
