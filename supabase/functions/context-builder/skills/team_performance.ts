export async function buildTeamPerformanceContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  const { data, error } = await supabaseAdmin.rpc('get_ai_team_performance_context', {
    p_company_id: companyId,
    p_leader_id: profileId
  });

  if (error || !data) {
    console.error("Failed to fetch team performance context:", error);
    return { error: "Failed to generate team context from database." };
  }

  return data;
}
