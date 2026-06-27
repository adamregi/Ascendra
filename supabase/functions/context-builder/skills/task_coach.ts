export async function buildTaskCoachContext(supabaseAdmin: any, companyId: string, profileId: string, question: string) {
  try {
    const { data: context, error } = await supabaseAdmin.rpc('get_ai_task_coach_context', {
      p_company_id: companyId,
      p_leader_id: profileId
    });

    if (error) {
      console.error("Failed to get task coach context:", error);
      return { error: "Failed to retrieve task analytics." };
    }

    return context || {};
  } catch (err: any) {
    console.error("Error in task coach context builder:", err);
    return { error: "Failed to build task context." };
  }
}
