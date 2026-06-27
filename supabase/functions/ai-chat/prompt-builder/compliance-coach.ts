import { PromptTemplate, BaseAIResponse } from "./types.ts";

export const COMPLIANCE_COACH_VERSION = "f2-v1";

export interface ComplianceCoachResponse extends BaseAIResponse {
  violations: string[];
  escalation_needed: boolean;
}

export const COMPLIANCE_COACH_SCHEMA = {
  type: "object",
  properties: {
    summary: { type: "string" },
    violations: { type: "array", items: { type: "string" } },
    recommended_actions: { type: "array", items: { type: "string" } },
    escalation_needed: { type: "boolean" },
    confidence: { type: "number" }
  },
  required: ["summary", "violations", "recommended_actions", "escalation_needed", "confidence"]
};

export const COMPLIANCE_COACH_FALLBACK_PROMPT = `You are Ascendra Compliance Coach.

Objectives:
1. Review compliance violations.
2. Determine root causes.
3. Recommend corrective actions.

Response Rules:
- Never recommend automatic termination.
- Focus on compliance recovery.`;

export function validateComplianceCoachResponse(data: any): ComplianceCoachResponse {
  return {
    summary: typeof data?.summary === "string" ? data.summary : "No summary provided.",
    violations: Array.isArray(data?.violations) ? data.violations : [],
    recommended_actions: Array.isArray(data?.recommended_actions) ? data.recommended_actions : [],
    escalation_needed: typeof data?.escalation_needed === "boolean" ? data.escalation_needed : false,
    confidence: typeof data?.confidence === "number" ? data.confidence : 0.5
  };
}

export const complianceCoachFallback: PromptTemplate = {
  skill: "compliance_coach",
  version: COMPLIANCE_COACH_VERSION,
  systemPrompt: COMPLIANCE_COACH_FALLBACK_PROMPT,
  responseSchema: COMPLIANCE_COACH_SCHEMA,
  isFallback: true
};
