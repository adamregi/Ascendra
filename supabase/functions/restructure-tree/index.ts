import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

export default {
  // Can be called internally by run-termination-check or manually by administrators (using secret key)
  fetch: withSupabase({ auth: ["secret", "user", "publishable"] }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { terminatedProfileId } = await req.json();

      if (!terminatedProfileId) {
        return errorResponse("Missing required field: terminatedProfileId");
      }

      // Call the stored procedure to restructure the tree atomically
      const { data, error } = await ctx.supabaseAdmin.rpc("restructure_network_tree", {
        p_terminated_id: terminatedProfileId
      });

      if (error) {
        return errorResponse(`Database error during restructuring: ${error.message}`);
      }

      return successResponse(data, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
