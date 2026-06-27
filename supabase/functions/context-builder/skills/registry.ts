import { buildTeamPerformanceContext } from "./team_performance.ts";
import { buildComplianceCoachContext } from "./compliance_coach.ts";
import { buildMeetingCoachContext } from "./meeting_coach.ts";
import { buildTaskCoachContext } from "./task_coach.ts";
import { buildMemberSuccessContext } from "./member_success.ts";
import { buildKnowledgeAssistantContext } from "./knowledge_assistant.ts";
import { buildLeadershipAdvisorContext } from "./leadership_advisor.ts";
import { buildRetentionRiskContext } from "./retention_risk.ts";
import { buildGrowthOpportunityContext } from "./growth_opportunity.ts";
import { buildPromotionAdvisorContext } from "./promotion_advisor.ts";
import { buildRecognitionCoachContext } from "./recognition_coach.ts";
import { buildExecutiveAdvisorContext } from "./executive_advisor.ts";
import { buildSystemAssistantContext } from "./system_assistant.ts";

export type BuildContextFunction = (supabaseAdmin: any, companyId: string, profileId: string, question: string) => Promise<any>;

const registry: Record<string, BuildContextFunction> = {
  team_performance: buildTeamPerformanceContext,
  compliance_coach: buildComplianceCoachContext,
  meeting_coach: buildMeetingCoachContext,
  task_coach: buildTaskCoachContext,
  member_success: buildMemberSuccessContext,
  knowledge_assistant: buildKnowledgeAssistantContext,
  leadership_advisor: buildLeadershipAdvisorContext,
  retention_risk: buildRetentionRiskContext,
  growth_opportunity: buildGrowthOpportunityContext,
  promotion_advisor: buildPromotionAdvisorContext,
  recognition_coach: buildRecognitionCoachContext,
  executive_advisor: buildExecutiveAdvisorContext,
  system_assistant: buildSystemAssistantContext,
};

export async function getSkillContract(skill: string): Promise<BuildContextFunction | null> {
    return registry[skill] || null;
}
