export async function buildGrowthOpportunityContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_growth_opportunity_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get growth opportunity context:", error);
      return { error: "Failed to retrieve growth analytics." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in growth opportunity context builder:", err);
    return { error: "Failed to build growth context." };
  }
}
