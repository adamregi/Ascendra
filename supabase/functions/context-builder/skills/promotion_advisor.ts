export async function buildPromotionAdvisorContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_promotion_advisor_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get promotion advisor context:", error);
      return { error: "Failed to retrieve promotion analytics." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in promotion advisor context builder:", err);
    return { error: "Failed to build promotion context." };
  }
}
