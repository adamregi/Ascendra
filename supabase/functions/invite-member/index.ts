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

      const { email, companyId } = await req.json();

      if (!email || !companyId) {
        return errorResponse("Missing required fields: email, companyId");
      }

      const leaderId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!leaderId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // Verify caller is an active leader of the specified company
      const { data: leaderProfile, error: profileError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("*")
        .eq("id", leaderId)
        .single();

      if (profileError || !leaderProfile) {
        return errorResponse(`Could not fetch leader profile: ${profileError?.message || "Profile not found"}`, 404);
      }

      if (leaderProfile.role !== "leader") {
        return errorResponse("Forbidden: Only leaders can invite members", 403);
      }

      if (leaderProfile.company_id !== companyId) {
        return errorResponse("Forbidden: Leader company mismatch", 403);
      }

      if (leaderProfile.status !== "active") {
        return errorResponse("Forbidden: Only active leaders can invite members", 403);
      }

      // Generate secure random token
      const token = crypto.randomUUID();
      const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString(); // 24 hours expiry

      // Insert invitation
      const { error: inviteError } = await ctx.supabaseAdmin
        .from("invitations")
        .insert({
          company_id: companyId,
          leader_id: leaderId,
          email,
          token,
          expires_at: expiresAt,
          status: "pending"
        });

      if (inviteError) {
        return errorResponse(`Failed to store invitation: ${inviteError.message}`);
      }

      // Mock email sending
      console.log(`[Email Mock] Sending invitation email to ${email} with token ${token}. Expiring at ${expiresAt}`);

      const appUrl = Deno.env.get("APP_URL") || "http://localhost:3000";
      const inviteLink = `${appUrl}/accept-invite?token=${token}`;

      return successResponse({ inviteLink }, 201);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
