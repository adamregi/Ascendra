export async function buildRetentionRiskContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_retention_risk_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get retention risk context:", error);
      return { error: "Failed to retrieve retention risk analytics." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in retention risk context builder:", err);
    return { error: "Failed to build retention risk context." };
  }
}
