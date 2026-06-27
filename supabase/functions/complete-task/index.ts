import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

export default {
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { taskId, completionNote, metadata } = await req.json();

      if (!taskId) {
        return errorResponse("Missing required field: taskId");
      }

      const actorId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!actorId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      const { data: task, error: taskFetchError } = await ctx.supabaseAdmin
        .from("tasks")
        .select("*")
        .eq("id", taskId)
        .single();

      if (taskFetchError || !task) {
        return errorResponse(`Could not fetch task: ${taskFetchError?.message || "Task not found"}`, 404);
      }

      if (task.created_by !== actorId && task.assigned_to !== actorId) {
        return errorResponse("Forbidden: Only the task creator or assignee can complete this task", 403);
      }

      if (task.status === "cancelled") {
        return errorResponse("Cannot complete a cancelled task", 409);
      }

      if (task.status === "completed") {
        return successResponse(task, 200);
      }

      const completedAt = new Date().toISOString();
      const eventMetadata = metadata && typeof metadata === "object" ? metadata : {};

      const { data: updatedTask, error: updateError } = await ctx.supabaseAdmin
        .from("tasks")
        .update({
          status: "completed",
          completed_at: completedAt
        })
        .eq("id", taskId)
        .select()
        .single();

      if (updateError || !updatedTask) {
        return errorResponse(`Failed to complete task: ${updateError?.message || "Unknown error"}`);
      }

      const { error: eventError } = await ctx.supabaseAdmin
        .from("task_events")
        .insert({
          task_id: taskId,
          actor_id: actorId,
          event_type: "completed",
          note: completionNote ?? null,
          metadata: {
            ...eventMetadata,
            completedAt
          }
        });

      if (eventError) {
        console.error(`Failed to log task completion event: ${eventError.message}`);
      }

      if (task.created_by !== actorId) {
        const { error: notificationError } = await ctx.supabaseAdmin
          .from("notifications")
          .insert({
            company_id: task.company_id,
            recipient_id: task.created_by,
            actor_id: actorId,
            task_id: taskId,
            type: "task_completed",
            title: "Task completed",
            body: task.title,
            metadata: {
              completedAt
            }
          });

        if (notificationError) {
          console.error(`Failed to create task completion notification: ${notificationError.message}`);
        }
      }

      return successResponse(updatedTask, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
