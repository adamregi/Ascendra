export async function buildRecognitionCoachContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_recognition_coach_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get recognition coach context:", error);
      return { error: "Failed to retrieve recognition analytics." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in recognition coach context builder:", err);
    return { error: "Failed to build recognition context." };
  }
}
