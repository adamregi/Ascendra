export async function buildSystemAssistantContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  return {
    user_role: "leader",
    subscription_plan: "enterprise",
    features_available: ["meetings", "tasks", "compliance", "knowledge_base"]
  };
}
