import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

export default {
  /**
   * POST /functions/v1/mark-notifications-read
   *
   * Marks one or more notifications as read for the authenticated user.
   * Only notifications owned by the user (recipient_id = userId) can be
   * marked as read.
   *
   * Body:
   *   { notificationIds: string[] }       — mark specific notifications
   *   { markAll: true }                   — mark all unread notifications
   *
   * Auth: User JWT
   */
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      const { notificationIds, markAll } = await req.json();

      if (!markAll && (!notificationIds || !Array.isArray(notificationIds) || notificationIds.length === 0)) {
        return errorResponse(
          "Missing required field: notificationIds (array) or markAll (boolean)",
          400
        );
      }

      const readAt = new Date().toISOString();

      if (markAll) {
        // Mark all unread notifications as read for this user
        const { data: updated, error: updateError } = await ctx.supabaseAdmin
          .from("notifications")
          .update({ read_at: readAt })
          .eq("recipient_id", userId)
          .is("read_at", null)
          .select("id");

        if (updateError) {
          return errorResponse(
            `Failed to mark notifications as read: ${updateError.message}`,
            500
          );
        }

        return successResponse({
          message: "All notifications marked as read",
          count: updated?.length || 0,
        }, 200);
      }

      // Validate max batch size
      if (notificationIds.length > 100) {
        return errorResponse(
          "Maximum 100 notifications can be marked at once",
          400
        );
      }

      // Mark specific notifications as read (only if owned by user)
      const { data: updated, error: updateError } = await ctx.supabaseAdmin
        .from("notifications")
        .update({ read_at: readAt })
        .eq("recipient_id", userId)
        .in("id", notificationIds)
        .is("read_at", null)
        .select("id");

      if (updateError) {
        return errorResponse(
          `Failed to mark notifications as read: ${updateError.message}`,
          500
        );
      }

      return successResponse({
        message: "Notifications marked as read",
        count: updated?.length || 0,
        markedIds: updated?.map((n: any) => n.id) || [],
      }, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
