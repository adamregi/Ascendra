import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

export default {
  // Support user JWT (client calls) as well as publishable and secret keys
  fetch: withSupabase({ auth: ["user", "publishable", "secret"] }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { meetingId, eventType, profileId: inputProfileId, metadata } = await req.json();

      if (!meetingId || !eventType) {
        return errorResponse("Missing required fields: meetingId, eventType");
      }

      const validEventTypes = ["join", "leave", "disconnect", "reconnect"];
      if (!validEventTypes.includes(eventType)) {
        return errorResponse("Invalid eventType. Must be 'join', 'leave', 'disconnect', or 'reconnect'");
      }

      // Determine profile ID from token if not explicitly provided
      let profileId = inputProfileId;
      if (!profileId && ctx.userClaims) {
        profileId = ctx.userClaims.sub || ctx.userClaims.id;
      }

      if (!profileId) {
        return errorResponse("Missing profileId. Authenticated user token or explicit profileId required.", 400);
      }

      const eventMetadata = metadata && typeof metadata === "object" ? metadata : {};
      const eventTime = new Date();

      const logAttendanceEvent = async (
        attendanceId?: string,
        extraMetadata: Record<string, unknown> = {}
      ) => {
        const { error: eventError } = await ctx.supabaseAdmin
          .from("attendance_events")
          .insert({
            meeting_id: meetingId,
            profile_id: profileId,
            attendance_id: attendanceId ?? null,
            event_type: eventType,
            occurred_at: eventTime.toISOString(),
            metadata: {
              ...eventMetadata,
              ...extraMetadata
            }
          });

        if (eventError) {
          console.error(`Failed to log attendance event: ${eventError.message}`);
        }
      };

      if (eventType === "join" || eventType === "reconnect") {
        const { data: existingOpenRecord, error: existingFetchError } = await ctx.supabaseAdmin
          .from("meeting_attendances")
          .select("*")
          .eq("meeting_id", meetingId)
          .eq("profile_id", profileId)
          .is("left_at", null)
          .order("joined_at", { ascending: false })
          .limit(1)
          .maybeSingle();

        if (existingFetchError) {
          return errorResponse(`Database error fetching attendance: ${existingFetchError.message}`);
        }

        if (existingOpenRecord) {
          await logAttendanceEvent(existingOpenRecord.id, { duplicateOpenSession: true });
          return successResponse(existingOpenRecord, 200);
        }

        // Create a new attendance segment.
        const { data: record, error: joinError } = await ctx.supabaseAdmin
          .from("meeting_attendances")
          .insert({
            meeting_id: meetingId,
            profile_id: profileId,
            joined_at: eventTime.toISOString()
          })
          .select()
          .single();

        if (joinError) {
          return errorResponse(`Failed to record ${eventType}: ${joinError.message}`);
        }

        await logAttendanceEvent(record.id);
        return successResponse(record, 201);
      } else {
        // eventType === "leave" or "disconnect"
        // Find latest open attendance record
        const { data: openRecord, error: fetchError } = await ctx.supabaseAdmin
          .from("meeting_attendances")
          .select("*")
          .eq("meeting_id", meetingId)
          .eq("profile_id", profileId)
          .is("left_at", null)
          .order("joined_at", { ascending: false })
          .limit(1)
          .maybeSingle();

        if (fetchError) {
          return errorResponse(`Database error fetching attendance: ${fetchError.message}`);
        }

        if (!openRecord) {
          await logAttendanceEvent(undefined, { ignored: true, reason: "no_open_attendance" });
          return errorResponse("No active attendance record found for this meeting and user.", 404);
        }

        const joinedAt = new Date(openRecord.joined_at);
        const durationSeconds = Math.max(0, Math.round((eventTime.getTime() - joinedAt.getTime()) / 1000));

        const { data: updatedRecord, error: leaveError } = await ctx.supabaseAdmin
          .from("meeting_attendances")
          .update({
            left_at: eventTime.toISOString(),
            duration_seconds: durationSeconds
          })
          .eq("id", openRecord.id)
          .select()
          .single();

        if (leaveError) {
          return errorResponse(`Failed to record ${eventType}: ${leaveError.message}`);
        }

        await logAttendanceEvent(openRecord.id, { durationSeconds });
        return successResponse(updatedRecord, 200);
      }
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
