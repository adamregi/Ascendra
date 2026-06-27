export async function buildExecutiveAdvisorContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_executive_advisor_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get executive advisor context:", error);
      return { error: "Failed to retrieve executive dashboard." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in executive advisor context builder:", err);
    return { error: "Failed to build executive context." };
  }
}
