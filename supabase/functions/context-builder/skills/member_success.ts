export async function buildMemberSuccessContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    // 1. Resolve Entity
    const { data: resolution, error: resolveError } = await supabaseAdmin.rpc('resolve_member_reference', {
      p_leader_id: profileId,
      p_query: question
    });

    if (resolveError) {
      console.error("Entity resolution failed:", resolveError);
      return { error: "Failed to resolve member reference." };
    }

    if (resolution.needs_clarification) {
      return {
        needs_clarification: true,
        clarification_prompt: "Could you please specify which member you are referring to?",
        candidates: resolution.candidates || []
      };
    }

    const targetProfileId = resolution.candidates[0].profile_id;

    // 2. Fetch Context
    const { data: context, error: contextError } = await supabaseAdmin.rpc('get_ai_member_success_context', {
      p_company_id: companyId,
      p_leader_id: profileId,
      p_target_profile_id: targetProfileId
    });

    if (contextError) {
      console.error("Failed to get member success context:", contextError);
      return { error: "Failed to retrieve member analytics." };
    }

    return {
      target_member: resolution.candidates[0],
      ...context
    };
  } catch (err: any) {
    console.error("Error in member success context builder:", err);
    return { error: "Failed to build member success context." };
  }
}
