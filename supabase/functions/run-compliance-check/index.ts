import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

export default {
  // Can be invoked via scheduled cron jobs (secret key) or manual triggers
  fetch: withSupabase({ auth: ["secret", "user", "publishable"] }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      // Fetch all member profiles that are active or warned
      const { data: members, error: membersError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("*")
        .eq("role", "member")
        .in("status", ["active", "warned"]);

      if (membersError) {
        return errorResponse(`Failed to fetch profiles: ${membersError.message}`);
      }

      const results = {
        totalChecked: members?.length || 0,
        warned: [] as string[],
        restored: [] as string[],
        unchanged: 0
      };

      const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString();

      const logComplianceEvent = async (
        member: any,
        eventType: "warned" | "warning_removed",
        reason: string,
        metadata: Record<string, unknown>
      ) => {
        const { error: eventError } = await ctx.supabaseAdmin
          .from("compliance_events")
          .insert({
            profile_id: member.id,
            event_type: eventType,
            reason,
            metadata
          });

        if (eventError) {
          console.error(`Failed to log compliance event for ${member.id}: ${eventError.message}`);
        }
      };

      const notifyMember = async (
        member: any,
        type: "compliance_warning" | "compliance_restored",
        title: string,
        body: string,
        metadata: Record<string, unknown>
      ) => {
        const { error: notificationError } = await ctx.supabaseAdmin
          .from("notifications")
          .insert({
            company_id: member.company_id,
            recipient_id: member.id,
            actor_id: null,
            type,
            title,
            body,
            metadata
          });

        if (notificationError) {
          console.error(`Failed to create compliance notification for ${member.id}: ${notificationError.message}`);
        }
      };

      for (const member of (members || [])) {
        // 1. Fetch compliance rules for the company
        const { data: rule } = await ctx.supabaseAdmin
          .from("compliance_rules")
          .select("*")
          .eq("company_id", member.company_id)
          .maybeSingle();

        const minDurationMinutes = rule?.min_attendance_duration_minutes ?? 30;
        const minCount = rule?.min_attendance_count_per_month ?? 4;
        const minDurationSeconds = minDurationMinutes * 60;

        // 2. Fetch all attendance records for this member in the last 30 days
        const { data: attendances } = await ctx.supabaseAdmin
          .from("meeting_attendances")
          .select("meeting_id, duration_seconds")
          .eq("profile_id", member.id)
          .gte("joined_at", thirtyDaysAgo);

        // 3. Aggregate duration by meeting ID (handles multiple joins/leaves in one meeting)
        const meetingDurations = new Map<string, number>();
        for (const att of (attendances || [])) {
          const dur = att.duration_seconds || 0;
          meetingDurations.set(att.meeting_id, (meetingDurations.get(att.meeting_id) || 0) + dur);
        }

        // 4. Count meetings meeting the minimum duration criteria
        let compliantMeetingsCount = 0;
        for (const [_, totalDuration] of meetingDurations.entries()) {
          if (totalDuration >= minDurationSeconds) {
            compliantMeetingsCount++;
          }
        }

        // 5. Evaluate compliance
        const isCompliant = compliantMeetingsCount >= minCount;

        if (isCompliant) {
          if (member.status === "warned") {
            // Restore to active
            const { error: updateError } = await ctx.supabaseAdmin
              .from("profiles")
              .update({ status: "active", warned_at: null })
              .eq("id", member.id);

            if (!updateError) {
              results.restored.push(member.id);
              const reason = "Attendance compliance restored.";
              const metadata = {
                compliantMeetingsCount,
                minAttendanceCount: minCount,
                minAttendanceDurationSeconds: minDurationSeconds,
                windowDays: 30
              };
              await logComplianceEvent(member, "warning_removed", reason, metadata);
              await notifyMember(
                member,
                "compliance_restored",
                "Compliance warning removed",
                reason,
                metadata
              );
            } else {
              console.error(`Failed to restore user ${member.id}: ${updateError.message}`);
            }
          } else {
            results.unchanged++;
          }
        } else {
          // Not compliant
          if (member.status === "active") {
            // Warn the user
            const warnedAt = new Date().toISOString();
            const { error: updateError } = await ctx.supabaseAdmin
              .from("profiles")
              .update({ status: "warned", warned_at: warnedAt })
              .eq("id", member.id);

            if (!updateError) {
              results.warned.push(member.id);
              const reason = `Attendance below compliance threshold: ${compliantMeetingsCount}/${minCount} qualifying meetings in the last 30 days.`;
              const metadata = {
                compliantMeetingsCount,
                minAttendanceCount: minCount,
                minAttendanceDurationSeconds: minDurationSeconds,
                warnedAt,
                windowDays: 30
              };
              await logComplianceEvent(member, "warned", reason, metadata);
              await notifyMember(
                member,
                "compliance_warning",
                "Compliance warning",
                reason,
                metadata
              );
            } else {
              console.error(`Failed to warn user ${member.id}: ${updateError.message}`);
            }
          } else {
            results.unchanged++;
          }
        }
      }

      return successResponse({
        message: "Compliance check completed successfully",
        results
      }, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
