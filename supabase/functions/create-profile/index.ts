import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";
import { validateRequired, sanitizeString } from "../_shared/utils/validation.ts";
import { logAudit } from "../_shared/utils/audit.ts";

export default {
  /**
   * POST /functions/v1/create-profile
   *
   * Creates a member profile for a user who has already authenticated.
   * This is intended for scenarios where the member profile needs to be
   * created outside of the accept-invitation flow (e.g., admin creating
   * a member, or re-activation scenarios).
   *
   * For leader + company creation, use the create-company endpoint instead.
   *
   * Body: { fullName: string, companyId: string }
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

      const body = await req.json();
      const fullName = sanitizeString(body.fullName || "");
      const companyId = body.companyId;

      validateRequired({ fullName, companyId });

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // Check if user already has a profile
      const { data: existingProfile } = await ctx.supabaseAdmin
        .from("profiles")
        .select("id")
        .eq("id", userId)
        .maybeSingle();

      if (existingProfile) {
        return errorResponse(
          "User already has a profile. Cannot create a second profile.",
          409
        );
      }

      // Verify company exists
      const { data: company, error: companyError } = await ctx.supabaseAdmin
        .from("companies")
        .select("id")
        .eq("id", companyId)
        .single();

      if (companyError || !company) {
        return errorResponse(
          `Company not found: ${companyError?.message || "Invalid companyId"}`,
          404
        );
      }

      // Members only — leaders are created via create-company
      const role = "member";

      // 1. Insert profile
      const { data: profile, error: profileError } = await ctx.supabaseAdmin
        .from("profiles")
        .insert({
          id: userId,
          full_name: fullName,
          company_id: companyId,
          role,
          status: "active",
          email: ctx.userClaims.email || null,
        })
        .select()
        .single();

      if (profileError) {
        return errorResponse(
          `Failed to create profile: ${profileError.message}`
        );
      }

      // 2. Audit log
      await logAudit(ctx.supabaseAdmin, {
        companyId,
        actorId: userId,
        targetId: userId,
        action: "created",
        entityType: "profile",
        after: { fullName, role, companyId },
      });

      return successResponse(profile, 201);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
