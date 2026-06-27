export async function buildComplianceCoachContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  const { data, error } = await supabaseAdmin.rpc('get_ai_compliance_context', {
    p_company_id: companyId,
    p_leader_id: profileId
  });

  if (error || !data) {
    console.error("Failed to fetch compliance context:", error);
    return { error: "Failed to generate compliance context from database." };
  }

  return data;
}
