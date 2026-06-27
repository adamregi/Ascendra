import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

async function generateHMSManagementToken(accessKey: string, secret: string): Promise<string> {
  const encoder = new TextEncoder();
  const secretKeyData = encoder.encode(secret);
  const key = await crypto.subtle.importKey(
    "raw",
    secretKeyData,
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"]
  );

  const header = {
    alg: "HS256",
    typ: "JWT"
  };

  const payload = {
    access_key: accessKey,
    type: "management",
    version: 2,
    iat: Math.floor(Date.now() / 1000),
    exp: Math.floor(Date.now() / 1000) + 24 * 60 * 60 // 24 hours expiry
  };

  const base64UrlEncode = (str: string) => {
    return btoa(str)
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=/g, "");
  };

  const encodedHeader = base64UrlEncode(JSON.stringify(header));
  const encodedPayload = base64UrlEncode(JSON.stringify(payload));

  const dataToSign = encoder.encode(`${encodedHeader}.${encodedPayload}`);
  const signature = await crypto.subtle.sign("HMAC", key, dataToSign);

  const encodedSignature = btoa(String.fromCharCode(...new Uint8Array(signature)))
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=/g, "");

  return `${encodedHeader}.${encodedPayload}.${encodedSignature}`;
}

export default {
  fetch: withSupabase({ auth: "user" }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    try {
      if (req.method !== "POST") {
        return errorResponse("Method not allowed", 405);
      }

      const { title, scheduledAt } = await req.json();

      if (!title || !scheduledAt) {
        return errorResponse("Missing required fields: title, scheduledAt");
      }

      const leaderId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!leaderId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // 1. Verify caller is an active leader
      const { data: leaderProfile, error: profileError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("*")
        .eq("id", leaderId)
        .single();

      if (profileError || !leaderProfile) {
        return errorResponse(`Could not fetch leader profile: ${profileError?.message || "Profile not found"}`, 404);
      }

      if (leaderProfile.role !== "leader") {
        return errorResponse("Forbidden: Only leaders can schedule meetings", 403);
      }

      if (leaderProfile.status !== "active") {
        return errorResponse("Forbidden: Only active leaders can schedule meetings", 403);
      }

      // 2. Create 100ms room
      let roomId = `mock-room-${crypto.randomUUID()}`;
      const accessKey = Deno.env.get("HMS_ACCESS_KEY");
      const secretKey = Deno.env.get("HMS_SECRET");

      if (accessKey && secretKey) {
        try {
          const managementToken = await generateHMSManagementToken(accessKey, secretKey);
          const response = await fetch("https://api.100ms.live/v2/rooms", {
            method: "POST",
            headers: {
              "Authorization": `Bearer ${managementToken}`,
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              name: `meeting-${crypto.randomUUID()}`.substring(0, 64),
              description: title
            })
          });

          if (response.ok) {
            const data = await response.json();
            roomId = data.id;
            console.log(`Successfully created 100ms room: ${roomId}`);
          } else {
            const errorText = await response.text();
            console.error(`100ms Room API failed: ${response.status} - ${errorText}. Falling back to mock room.`);
          }
        } catch (tokenErr) {
          console.error("Failed to generate token or request 100ms room, falling back to mock room:", tokenErr);
        }
      } else {
        console.log("HMS credentials missing. Created mock room ID.");
      }

      // 3. Insert meeting record
      const { data: meeting, error: meetingError } = await ctx.supabaseAdmin
        .from("meetings")
        .insert({
          company_id: leaderProfile.company_id,
          leader_id: leaderId,
          title,
          scheduled_at: scheduledAt,
          room_id: roomId
        })
        .select()
        .single();

      if (meetingError) {
        return errorResponse(`Failed to insert meeting record: ${meetingError.message}`);
      }

      return successResponse(meeting, 201);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
