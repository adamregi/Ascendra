import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";
import { validateRequired, sanitizeString, generateSlug } from "../_shared/utils/validation.ts";

export default {
  /**
   * POST /functions/v1/create-company
   *
   * Creates a new company along with:
   *   • The leader's profile (role = 'leader')
   *   • A root network node for the leader
   *   • Default company_settings
   *   • Default compliance_rules
   *   • An audit log entry
   *
   * All operations run inside a single database transaction via the
   * create_company_atomic() stored procedure, which uses DEFERRABLE
   * constraints to handle the circular FK between companies ↔ profiles.
   *
   * Body: { name: string, fullName: string, slug?: string, logoUrl?: string }
   *
   * Auth: User JWT (the authenticated user becomes the company owner/leader).
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
      const name = sanitizeString(body.name || "");
      const fullName = sanitizeString(body.fullName || "");
      const customSlug = body.slug ? generateSlug(body.slug) : "";

      validateRequired({ name, fullName });

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // 1. Check if user already has a profile
      const { data: existingProfile } = await ctx.supabaseAdmin
        .from("profiles")
        .select("id")
        .eq("id", userId)
        .maybeSingle();

      if (existingProfile) {
        return errorResponse(
          "User already has a profile. A user can only belong to one company.",
          409
        );
      }

      // 2. Generate and validate slug
      const slug = customSlug || generateSlug(name);
      if (!slug) {
        return errorResponse(
          "Could not generate a valid slug from the company name. Please provide a slug.",
          400
        );
      }

      // 3. Check slug uniqueness
      const { data: existingCompany } = await ctx.supabaseAdmin
        .from("companies")
        .select("id")
        .ilike("slug", slug)
        .maybeSingle();

      if (existingCompany) {
        return errorResponse(
          `Company slug "${slug}" is already taken. Choose a different name or slug.`,
          409
        );
      }

      // 4. Create everything atomically via the stored procedure
      const { data: result, error: rpcError } = await ctx.supabaseAdmin.rpc(
        "create_company_atomic",
        {
          p_user_id: userId,
          p_company_name: name,
          p_company_slug: slug,
          p_full_name: fullName,
          p_logo_url: body.logoUrl || null,
        }
      );

      if (rpcError) {
        console.error(`create_company_atomic failed: ${rpcError.message}`);
        return errorResponse(
          `Failed to create company: ${rpcError.message}`,
          500
        );
      }

      return successResponse(result, 201);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
