import { PromptTemplate, PromptBuilderResult } from "./types.ts";
import { teamPerformanceFallback } from "./team-performance.ts";
import { complianceCoachFallback } from "./compliance-coach.ts";
import { meetingCoachFallback } from "./meeting-coach.ts";
import { taskCoachFallback } from "./task-coach.ts";
import { memberSuccessFallback } from "./member-success.ts";
import { knowledgeAssistantFallback } from "./knowledge-assistant.ts";
import { leadershipAdvisorFallback } from "./leadership-advisor.ts";
import { retentionRiskFallback } from "./retention-risk.ts";
import { growthOpportunityFallback } from "./growth-opportunity.ts";
import { systemAssistantFallback } from "./system-assistant.ts";

const FALLBACK_REGISTRY: Record<string, PromptTemplate> = {
  team_performance: teamPerformanceFallback,
  compliance_coach: complianceCoachFallback,
  meeting_coach: meetingCoachFallback,
  task_coach: taskCoachFallback,
  member_success: memberSuccessFallback,
  knowledge_assistant: knowledgeAssistantFallback,
  leadership_advisor: leadershipAdvisorFallback,
  retention_risk: retentionRiskFallback,
  growth_opportunity: growthOpportunityFallback,
  system_assistant: systemAssistantFallback
};

export async function buildPrompt(
  ctx: any, // Supabase context (needs supabaseAdmin)
  companyId: string,
  skill: string,
  operationalContext: any,
  docText: string
): Promise<PromptBuilderResult> {
  // 1. Fetch from database with company override logic
  let dbTemplate: any = null;
  
  try {
    // Try to find company-specific template first, then global
    const { data, error } = await ctx.supabaseAdmin
      .from('ai_response_templates')
      .select('*')
      .eq('skill', skill)
      .eq('is_active', true)
      .in('company_id', [companyId, null])
      .order('company_id', { ascending: true }) // UUID sorts before null typically, but let's just fetch both and pick in code to be safe
      .limit(2);
      
    if (!error && data && data.length > 0) {
      // Find company specific first
      dbTemplate = data.find((t: any) => t.company_id === companyId);
      if (!dbTemplate) {
        // Fallback to global
        dbTemplate = data.find((t: any) => t.company_id === null);
      }
    }
  } catch (err) {
    console.error("Failed to fetch template from DB:", err);
  }

  // 2. Select Template (DB or Fallback)
  let systemPrompt = "";
  let responseSchema = {};
  let version = "";

  if (dbTemplate) {
    systemPrompt = dbTemplate.system_prompt;
    responseSchema = dbTemplate.response_schema;
    version = dbTemplate.prompt_version;
  } else {
    console.warn(`Using fallback template for skill: ${skill}`);
    const fallback = FALLBACK_REGISTRY[skill] || knowledgeAssistantFallback;
    systemPrompt = fallback.systemPrompt;
    responseSchema = fallback.responseSchema;
    version = fallback.version + "-fallback";
  }

  // 3. Assemble the final instruction string
  const structuredContextText = Object.keys(operationalContext).length > 0
    ? JSON.stringify(operationalContext, null, 2)
    : "No operational data context provided.";

  const finalInstruction = 
    `${systemPrompt}

You MUST return a JSON object matching the provided response_schema exactly. Do not include markdown formatting like \`\`\`json.

---
Operational Context (JSON):
${structuredContextText}

Knowledge Documents Context:
${docText}`;

  return {
    systemInstruction: finalInstruction,
    responseSchema,
    promptVersion: version,
    schemaVersion: version // For now tying them together
  };
}
