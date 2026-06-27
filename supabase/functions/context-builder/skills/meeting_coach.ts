export async function buildMeetingCoachContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_meeting_coach_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get meeting coach context:", error);
      return { error: "Failed to retrieve meeting analytics." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in meeting coach context builder:", err);
    return { error: "Failed to build meeting context." };
  }
}
