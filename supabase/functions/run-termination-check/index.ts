import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

export default {
  fetch: withSupabase({ auth: ["secret", "user", "publishable"] }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      // Fetch all warned member profiles
      const { data: warnedMembers, error: fetchError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("*")
        .eq("status", "warned")
        .is("terminated_at", null);

      if (fetchError) {
        return errorResponse(`Failed to fetch warned profiles: ${fetchError.message}`);
      }

      const results = {
        totalChecked: warnedMembers?.length || 0,
        terminated: [] as string[],
        restructured: [] as string[],
        errors: [] as string[]
      };

      for (const member of (warnedMembers || [])) {
        if (!member.warned_at) continue;

        // 1. Fetch compliance rule for company to find grace period
        const { data: rule } = await ctx.supabaseAdmin
          .from("compliance_rules")
          .select("*")
          .eq("company_id", member.company_id)
          .maybeSingle();

        const gracePeriodDays = rule?.grace_period_days ?? 7;
        const warnedTime = new Date(member.warned_at).getTime();
        const expiryTime = warnedTime + gracePeriodDays * 24 * 60 * 60 * 1000;

        if (Date.now() > expiryTime) {
          // Grace period expired! Terminate user
          const terminatedAt = new Date().toISOString();
          const terminationReason = `Failed to meet compliance. Grace period of ${gracePeriodDays} days expired.`;

          // Update profile status
          const { error: profileError } = await ctx.supabaseAdmin
            .from("profiles")
            .update({
              status: "terminated",
              terminated_at: terminatedAt
            })
            .eq("id", member.id);

          if (profileError) {
            console.error(`Failed to terminate profile ${member.id}: ${profileError.message}`);
            results.errors.push(`Profile ${member.id}: ${profileError.message}`);
            continue;
          }

          // Insert termination log
          const { error: logError } = await ctx.supabaseAdmin
            .from("termination_logs")
            .insert({
              profile_id: member.id,
              terminated_at: terminatedAt,
              reason: terminationReason
            });

          if (logError) {
            console.error(`Failed to log termination for ${member.id}: ${logError.message}`);
          }

          const complianceMetadata = {
            gracePeriodDays,
            warnedAt: member.warned_at,
            terminatedAt
          };

          const { error: complianceEventError } = await ctx.supabaseAdmin
            .from("compliance_events")
            .insert({
              profile_id: member.id,
              event_type: "terminated",
              reason: terminationReason,
              metadata: complianceMetadata
            });

          if (complianceEventError) {
            console.error(`Failed to log compliance termination event for ${member.id}: ${complianceEventError.message}`);
          }

          const { error: notificationError } = await ctx.supabaseAdmin
            .from("notifications")
            .insert({
              company_id: member.company_id,
              recipient_id: member.id,
              actor_id: null,
              type: "compliance_terminated",
              title: "Account terminated",
              body: terminationReason,
              metadata: complianceMetadata
            });

          if (notificationError) {
            console.error(`Failed to create termination notification for ${member.id}: ${notificationError.message}`);
          }

          results.terminated.push(member.id);

          // 2. Trigger restructure-tree function asynchronously
          const supabaseUrl = Deno.env.get("SUPABASE_URL");
          const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

          if (supabaseUrl && serviceKey) {
            try {
              const functionUrl = `${supabaseUrl}/functions/v1/restructure-tree`;
              const response = await fetch(functionUrl, {
                method: "POST",
                headers: {
                  "Authorization": `Bearer ${serviceKey}`,
                  "Content-Type": "application/json"
                },
                body: JSON.stringify({ terminatedProfileId: member.id })
              });

              if (response.ok) {
                results.restructured.push(member.id);
                console.log(`Triggered restructure-tree for terminated user ${member.id} successfully.`);
              } else {
                const errText = await response.text();
                console.error(`Failed to restructure tree for ${member.id}: ${response.status} - ${errText}`);
                results.errors.push(`Restructure ${member.id}: ${errText}`);
              }
            } catch (fetchErr: any) {
              console.error(`Network error calling restructure-tree for ${member.id}: ${fetchErr.message}`);
              results.errors.push(`Restructure network error ${member.id}: ${fetchErr.message}`);
            }
          } else {
            console.warn("SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY missing in env. Restructure call skipped.");
          }
        }
      }

      return successResponse({
        message: "Termination check completed successfully",
        results
      }, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
