import { validateTeamPerformanceResponse } from "../prompt-builder/team-performance.ts";
import { validateComplianceCoachResponse } from "../prompt-builder/compliance-coach.ts";
import { validateMeetingCoachResponse } from "../prompt-builder/meeting-coach.ts";
import { validateTaskCoachResponse } from "../prompt-builder/task-coach.ts";
import { validateMemberSuccessResponse } from "../prompt-builder/member-success.ts";
import { validateKnowledgeAssistantResponse } from "../prompt-builder/knowledge-assistant.ts";
import { validateLeadershipAdvisorResponse } from "../prompt-builder/leadership-advisor.ts";
import { validateRetentionRiskResponse } from "../prompt-builder/retention-risk.ts";
import { validateGrowthOpportunityResponse } from "../prompt-builder/growth-opportunity.ts";
import { validateSystemAssistantResponse } from "../prompt-builder/system-assistant.ts";
import { BaseAIResponse } from "../prompt-builder/types.ts";

export interface ResponseProcessorContext {
  routingConfidence: number;
  retrievedChunkCount: number;
  operationalContextSourcesCount: number;
  retrievedDocumentIds: string[];
}

export interface ProcessedResponse {
  finalResponseText: string;
  parsedResponse: BaseAIResponse;
  finalConfidence: number;
  responseSources: Array<{ type: string; id: string }>;
}

export function processGeminiResponse(
  rawJsonString: string,
  skill: string,
  context: ResponseProcessorContext
): ProcessedResponse {
  // 1. Parse JSON
  let parsed: any = {};
  try {
    const cleanedJson = rawJsonString.replace(/^```json\s*/, '').replace(/\s*```$/, '').trim();
    parsed = JSON.parse(cleanedJson);
  } catch (err) {
    console.warn("Failed to parse Gemini response as JSON. Auto-repairing with defaults.", err);
    parsed = {
      summary: rawJsonString // fallback
    };
  }

  // 2. Validate & Repair Output based on Skill Contract
  let validated: BaseAIResponse;
  switch (skill) {
    case "team_performance":
      validated = validateTeamPerformanceResponse(parsed);
      break;
    case "compliance_coach":
      validated = validateComplianceCoachResponse(parsed);
      break;
    case "meeting_coach":
      validated = validateMeetingCoachResponse(parsed);
      break;
    case "task_coach":
      validated = validateTaskCoachResponse(parsed);
      break;
    case "member_success":
      validated = validateMemberSuccessResponse(parsed);
      break;
    case "knowledge_assistant":
      validated = validateKnowledgeAssistantResponse(parsed);
      break;
    case "leadership_advisor":
      validated = validateLeadershipAdvisorResponse(parsed);
      break;
    case "retention_risk":
      validated = validateRetentionRiskResponse(parsed);
      break;
    case "growth_opportunity":
      validated = validateGrowthOpportunityResponse(parsed);
      break;
    case "system_assistant":
      validated = validateSystemAssistantResponse(parsed);
      break;
    default:
      validated = validateKnowledgeAssistantResponse(parsed);
      break;
  }

  // 3. Confidence Calculation
  const routingScore = Math.max(0, Math.min(1, context.routingConfidence));
  
  // Base context score on whether we had operational context or RAG chunks
  let contextScore = 0.5; // baseline
  if (context.operationalContextSourcesCount > 0) {
    contextScore = 0.9;
  } else if (context.retrievedChunkCount > 0) {
    contextScore = 0.8;
  } else if (skill === 'system_assistant') {
    // system_assistant might not use chunks sometimes if purely instructional
    contextScore = 0.8; 
  }

  // Gemini's self reported confidence from the generated JSON
  const modelConfidence = Math.max(0, Math.min(1, validated.confidence));

  // Final confidence = 30% Routing + 40% Context Quality + 30% Model Confidence
  const finalConfidence = Number((
    (routingScore * 0.3) +
    (contextScore * 0.4) +
    (modelConfidence * 0.3)
  ).toFixed(2));

  // Override the validated confidence with our deterministic one
  validated.confidence = finalConfidence;

  // 4. Source Attribution Engine
  const responseSources: Array<{ type: string; id: string }> = [];
  
  // Add documents
  for (const docId of context.retrievedDocumentIds) {
    responseSources.push({ type: "document", id: docId });
  }

  // We could theoretically add operational data source attribution here
  // For example, if 'meetings' were part of operational context, we'd add it.
  // In F2, we'll keep it simple and just return the stringified JSON.
  
  return {
    finalResponseText: JSON.stringify(validated, null, 2),
    parsedResponse: validated,
    finalConfidence,
    responseSources
  };
}
