import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

export default {
  /**
   * GET /functions/v1/analytics-dashboard
   *
   * Returns aggregated dashboard data for the authenticated user's company.
   * Leaders get full company analytics; members get a subset.
   *
   * Query params:
   *   ?refresh=true  — Force refresh of materialized views before returning data
   *
   * Auth: User JWT
   */
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "GET") {
        return errorResponse("Method not allowed", 405);
      }

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // 1. Get user profile
      const { data: profile, error: profileError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("id, company_id, role, status, full_name")
        .eq("id", userId)
        .single();

      if (profileError || !profile) {
        return errorResponse(
          `Could not fetch profile: ${profileError?.message || "Not found"}`,
          404
        );
      }

      const companyId = profile.company_id;
      const isLeader = profile.role === "leader";

      // 2. Optionally refresh materialized views
      const url = new URL(req.url);
      if (url.searchParams.get("refresh") === "true" && isLeader) {
        try {
          await ctx.supabaseAdmin.rpc("refresh_analytics_views");
        } catch (refreshErr: any) {
          console.error(`Failed to refresh analytics views: ${refreshErr.message}`);
          // Continue anyway — stale data is better than no data
        }
      }

      // 3. Member counts (live query for accuracy)
      const { data: memberCounts } = await ctx.supabaseAdmin
        .from("profiles")
        .select("status")
        .eq("company_id", companyId);

      const statusCounts = {
        active: 0,
        warned: 0,
        terminated: 0,
        total: 0,
      };

      for (const m of memberCounts || []) {
        statusCounts.total++;
        if (m.status === "active") statusCounts.active++;
        else if (m.status === "warned") statusCounts.warned++;
        else if (m.status === "terminated") statusCounts.terminated++;
      }

      // 4. Meeting stats
      const now = new Date();
      const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1).toISOString();
      const startOfLastMonth = new Date(now.getFullYear(), now.getMonth() - 1, 1).toISOString();
      const endOfLastMonth = new Date(now.getFullYear(), now.getMonth(), 0, 23, 59, 59).toISOString();

      const { data: meetingsThisMonth } = await ctx.supabaseAdmin
        .from("meetings")
        .select("id")
        .eq("company_id", companyId)
        .gte("scheduled_at", startOfMonth);

      const { data: meetingsLastMonth } = await ctx.supabaseAdmin
        .from("meetings")
        .select("id")
        .eq("company_id", companyId)
        .gte("scheduled_at", startOfLastMonth)
        .lte("scheduled_at", endOfLastMonth);

      const { data: totalMeetings } = await ctx.supabaseAdmin
        .from("meetings")
        .select("id")
        .eq("company_id", companyId);

      // 5. Compliance rate (from live data for active+warned members)
      const activeAndWarned = statusCounts.active + statusCounts.warned;
      const complianceRate = statusCounts.total > 0
        ? Math.round((statusCounts.active / (activeAndWarned || 1)) * 100)
        : 100;

      // 6. Top performers by attendance (last 30 days)
      const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString();

      const { data: topPerformers } = await ctx.supabaseAdmin
        .rpc("get_top_performers", {
          p_company_id: companyId,
          p_since: thirtyDaysAgo,
          p_limit: 10,
        })
        .catch(() => ({ data: null }));

      // Fallback if RPC doesn't exist yet — basic query
      let performersList = topPerformers;
      if (!performersList) {
        const { data: attendanceSummary } = await ctx.supabaseAdmin
          .from("meeting_attendances")
          .select(`
            profile_id,
            profiles!inner(full_name, company_id, status),
            duration_seconds
          `)
          .eq("profiles.company_id", companyId)
          .gte("joined_at", thirtyDaysAgo);

        // Aggregate by profile
        const byProfile = new Map<string, { name: string; totalSeconds: number; meetingCount: number }>();
        for (const rec of attendanceSummary || []) {
          const existing = byProfile.get(rec.profile_id) || {
            name: (rec as any).profiles?.full_name || "Unknown",
            totalSeconds: 0,
            meetingCount: 0,
          };
          existing.totalSeconds += rec.duration_seconds || 0;
          existing.meetingCount += 1;
          byProfile.set(rec.profile_id, existing);
        }

        performersList = Array.from(byProfile.entries())
          .map(([profileId, data]) => ({
            profile_id: profileId,
            full_name: data.name,
            total_duration_seconds: data.totalSeconds,
            meeting_count: data.meetingCount,
          }))
          .sort((a, b) => b.total_duration_seconds - a.total_duration_seconds)
          .slice(0, 10);
      }

      // 7. Recent activity feed (last 20 notifications for the company, leader only)
      let recentActivity: any[] = [];
      if (isLeader) {
        const { data: activity } = await ctx.supabaseAdmin
          .from("notifications")
          .select("id, type, title, body, actor_id, recipient_id, created_at")
          .eq("company_id", companyId)
          .order("created_at", { ascending: false })
          .limit(20);

        recentActivity = activity || [];
      }

      // 8. Build response
      const dashboard = {
        company: {
          id: companyId,
        },
        members: statusCounts,
        meetings: {
          total: totalMeetings?.length || 0,
          thisMonth: meetingsThisMonth?.length || 0,
          lastMonth: meetingsLastMonth?.length || 0,
        },
        compliance: {
          rate: complianceRate,
          activeMembers: statusCounts.active,
          warnedMembers: statusCounts.warned,
        },
        topPerformers: performersList || [],
        ...(isLeader ? { recentActivity } : {}),
      };

      return successResponse(dashboard, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
