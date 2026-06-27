export async function buildLeadershipAdvisorContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_leadership_advisor_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get leadership advisor context:", error);
      return { error: "Failed to retrieve leadership analytics." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in leadership advisor context builder:", err);
    return { error: "Failed to build leadership context." };
  }
}
