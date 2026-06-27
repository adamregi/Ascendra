import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";
import { validateRequired } from "../_shared/utils/validation.ts";
import { logAudit } from "../_shared/utils/audit.ts";

export default {
  /**
   * POST /functions/v1/send-warning
   *
   * Allows a leader to manually issue a compliance warning to a member.
   * This is separate from the automated compliance check — it handles
   * ad-hoc warnings for policy violations, misconduct, etc.
   *
   * Body: { memberId: string, reason: string, metadata?: object }
   *
   * Auth: User JWT (must be a leader in the same company as the member)
   */
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { memberId, reason, metadata } = await req.json();
      validateRequired({ memberId, reason });

      const leaderId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!leaderId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // 1. Verify caller is an active leader
      const { data: leaderProfile, error: leaderError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("id, company_id, role, status, full_name")
        .eq("id", leaderId)
        .single();

      if (leaderError || !leaderProfile) {
        return errorResponse(
          `Could not fetch leader profile: ${leaderError?.message || "Not found"}`,
          404
        );
      }

      if (leaderProfile.role !== "leader") {
        return errorResponse("Forbidden: Only leaders can send warnings", 403);
      }

      if (leaderProfile.status !== "active") {
        return errorResponse("Forbidden: Only active leaders can send warnings", 403);
      }

      // 2. Verify target member exists, is in the same company, and is active
      const { data: memberProfile, error: memberError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("id, company_id, role, status, full_name")
        .eq("id", memberId)
        .single();

      if (memberError || !memberProfile) {
        return errorResponse(
          `Could not fetch member profile: ${memberError?.message || "Not found"}`,
          404
        );
      }

      if (memberProfile.company_id !== leaderProfile.company_id) {
        return errorResponse("Forbidden: Member is not in your company", 403);
      }

      if (memberProfile.status === "terminated") {
        return errorResponse("Cannot warn a terminated member", 409);
      }

      if (memberProfile.status === "warned") {
        return errorResponse("Member is already in warned status", 409);
      }

      const companyId = leaderProfile.company_id;
      const warnedAt = new Date().toISOString();
      const warningMetadata = metadata && typeof metadata === "object" ? metadata : {};

      // 3. Update member profile status to warned
      const { data: updatedProfile, error: updateError } = await ctx.supabaseAdmin
        .from("profiles")
        .update({ status: "warned", warned_at: warnedAt })
        .eq("id", memberId)
        .select()
        .single();

      if (updateError || !updatedProfile) {
        return errorResponse(
          `Failed to update member status: ${updateError?.message || "Unknown error"}`,
          500
        );
      }

      // 4. Create compliance event
      const { error: eventError } = await ctx.supabaseAdmin
        .from("compliance_events")
        .insert({
          profile_id: memberId,
          event_type: "warned",
          reason,
          metadata: {
            ...warningMetadata,
            issuedBy: leaderId,
            issuedByName: leaderProfile.full_name,
            warnedAt,
            manual: true,
          },
        });

      if (eventError) {
        console.error(
          `Failed to create compliance event: ${eventError.message}`
        );
      }

      // 5. Create notification for the warned member
      const { error: notificationError } = await ctx.supabaseAdmin
        .from("notifications")
        .insert({
          company_id: companyId,
          recipient_id: memberId,
          actor_id: leaderId,
          type: "compliance_warning",
          title: "You have received a warning",
          body: reason,
          metadata: {
            ...warningMetadata,
            warnedAt,
            manual: true,
          },
        });

      if (notificationError) {
        console.error(
          `Failed to create warning notification: ${notificationError.message}`
        );
      }

      // 6. Audit log
      await logAudit(ctx.supabaseAdmin, {
        companyId,
        actorId: leaderId,
        targetId: memberId,
        action: "warning_issued",
        entityType: "profile",
        before: { status: "active" },
        after: { status: "warned", warnedAt, reason },
      });

      return successResponse(
        {
          message: "Warning sent successfully",
          profile: updatedProfile,
        },
        200
      );
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
