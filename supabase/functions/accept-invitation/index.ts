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

      const { token, fullName } = await req.json();

      if (!token) {
        return errorResponse("Missing required field: token");
      }

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // 1. Get the invitation and check validity
      const { data: invitation, error: inviteError } = await ctx.supabaseAdmin
        .from("invitations")
        .select("*")
        .eq("token", token)
        .eq("status", "pending")
        .single();

      if (inviteError || !invitation) {
        return errorResponse("Invalid or expired invitation token", 404);
      }

      // Check expiry
      if (new Date(invitation.expires_at) < new Date()) {
        // Update status to expired
        await ctx.supabaseAdmin
          .from("invitations")
          .update({ status: "expired" })
          .eq("id", invitation.id);
        return errorResponse("Invitation token has expired", 410);
      }

      // 2. Create profile
      const email = invitation.email;
      const defaultName = email.split("@")[0];
      const memberName = fullName || defaultName;

      const { data: profile, error: profileError } = await ctx.supabaseAdmin
        .from("profiles")
        .insert({
          id: userId,
          full_name: memberName,
          company_id: invitation.company_id,
          role: "member",
          status: "active"
        })
        .select()
        .single();

      if (profileError) {
        return errorResponse(`Failed to create profile: ${profileError.message}`);
      }

      // 3. Assign leader and create network node
      // Get parent node to construct path
      const { data: parentNode, error: parentError } = await ctx.supabaseAdmin
        .from("network_nodes")
        .select("*")
        .eq("profile_id", invitation.leader_id)
        .single();

      let computedPath = userId;
      if (parentNode) {
        computedPath = `${parentNode.path}.${userId}`;
      } else {
        // Fallback: leader doesn't have a node, create one for them, then link
        console.warn(`Leader node for ${invitation.leader_id} not found. Creating fallback root for leader.`);
        await ctx.supabaseAdmin
          .from("network_nodes")
          .insert({
            profile_id: invitation.leader_id,
            parent_id: null,
            path: invitation.leader_id,
            children_count: 0,
            member_count: 0
          });
        computedPath = `${invitation.leader_id}.${userId}`;
      }

      const { data: node, error: nodeError } = await ctx.supabaseAdmin
        .from("network_nodes")
        .insert({
          profile_id: userId,
          parent_id: invitation.leader_id,
          path: computedPath,
          children_count: 0,
          member_count: 0
        })
        .select()
        .single();

      if (nodeError) {
        console.error(`Failed to create network node: ${nodeError.message}`);
        // We do not rollback the profile to avoid broken states, but log it
      } else {
        // 4. Update counts
        // Increment children_count of direct parent
        if (parentNode) {
          await ctx.supabaseAdmin
            .from("network_nodes")
            .update({ children_count: parentNode.children_count + 1 })
            .eq("profile_id", invitation.leader_id);
        } else {
          await ctx.supabaseAdmin
            .from("network_nodes")
            .update({ children_count: 1 })
            .eq("profile_id", invitation.leader_id);
        }

        // Increment member_count for all ancestors in the path (excluding the new node itself)
        const ancestorIds = computedPath.split(".");
        ancestorIds.pop(); // Remove the new member's ID

        for (const ancestorId of ancestorIds) {
          if (ancestorId) {
            const { data: ancestorNode } = await ctx.supabaseAdmin
              .from("network_nodes")
              .select("member_count")
              .eq("profile_id", ancestorId)
              .single();
            if (ancestorNode) {
              await ctx.supabaseAdmin
                .from("network_nodes")
                .update({ member_count: ancestorNode.member_count + 1 })
                .eq("profile_id", ancestorId);
            }
          }
        }
      }

      // 5. Update invitation status to accepted with audit fields
      const acceptedAt = new Date().toISOString();
      await ctx.supabaseAdmin
        .from("invitations")
        .update({
          status: "accepted",
          used_by: userId,
          accepted_at: acceptedAt
        })
        .eq("id", invitation.id);

      if (invitation.leader_id) {
        const { error: notificationError } = await ctx.supabaseAdmin
          .from("notifications")
          .insert({
            company_id: invitation.company_id,
            recipient_id: invitation.leader_id,
            actor_id: userId,
            type: "invite_accepted",
            title: "Invitation accepted",
            body: `${memberName} accepted your invitation.`,
            metadata: {
              invitationId: invitation.id,
              acceptedAt
            }
          });

        if (notificationError) {
          console.error(`Failed to create invitation notification: ${notificationError.message}`);
        }
      }

      return successResponse({
        profile,
        networkNode: node
      }, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
