import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

const VALID_PRIORITIES = new Set(["low", "normal", "high", "urgent"]);

export default {
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { assignedTo, title, description, dueAt, priority = "normal", metadata } = await req.json();

      if (!assignedTo || !title) {
        return errorResponse("Missing required fields: assignedTo, title");
      }

      if (!VALID_PRIORITIES.has(priority)) {
        return errorResponse("Invalid priority. Must be low, normal, high, or urgent");
      }

      const leaderId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!leaderId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      const { data: leaderProfile, error: leaderError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("id, company_id, role, status, full_name")
        .eq("id", leaderId)
        .single();

      if (leaderError || !leaderProfile) {
        return errorResponse(`Could not fetch leader profile: ${leaderError?.message || "Profile not found"}`, 404);
      }

      if (leaderProfile.role !== "leader") {
        return errorResponse("Forbidden: Only leaders can assign tasks", 403);
      }

      if (leaderProfile.status !== "active") {
        return errorResponse("Forbidden: Only active leaders can assign tasks", 403);
      }

      const { data: assigneeProfile, error: assigneeError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("id, company_id, status, full_name")
        .eq("id", assignedTo)
        .single();

      if (assigneeError || !assigneeProfile) {
        return errorResponse(`Could not fetch assignee profile: ${assigneeError?.message || "Profile not found"}`, 404);
      }

      if (assigneeProfile.company_id !== leaderProfile.company_id) {
        return errorResponse("Forbidden: Assignee company mismatch", 403);
      }

      if (assigneeProfile.status === "terminated") {
        return errorResponse("Cannot assign tasks to terminated members", 409);
      }

      const taskMetadata = metadata && typeof metadata === "object" ? metadata : {};

      const { data: task, error: taskError } = await ctx.supabaseAdmin
        .from("tasks")
        .insert({
          company_id: leaderProfile.company_id,
          created_by: leaderId,
          assigned_to: assignedTo,
          title,
          description: description ?? null,
          due_at: dueAt ?? null,
          priority,
          status: "open",
          metadata: taskMetadata
        })
        .select()
        .single();

      if (taskError || !task) {
        return errorResponse(`Failed to create task: ${taskError?.message || "Unknown error"}`);
      }

      const { error: eventError } = await ctx.supabaseAdmin
        .from("task_events")
        .insert([
          {
            task_id: task.id,
            actor_id: leaderId,
            event_type: "created",
            metadata: taskMetadata
          },
          {
            task_id: task.id,
            actor_id: leaderId,
            event_type: "assigned",
            metadata: {
              assignedTo
            }
          }
        ]);

      if (eventError) {
        console.error(`Failed to log task event: ${eventError.message}`);
      }

      const { error: notificationError } = await ctx.supabaseAdmin
        .from("notifications")
        .insert({
          company_id: leaderProfile.company_id,
          recipient_id: assignedTo,
          actor_id: leaderId,
          task_id: task.id,
          type: "task_assigned",
          title: "Task assigned",
          body: title,
          metadata: {
            dueAt: dueAt ?? null,
            priority
          }
        });

      if (notificationError) {
        console.error(`Failed to create task notification: ${notificationError.message}`);
      }

      return successResponse(task, 201);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
