import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { successResponse, errorResponse, corsHeaders } from "../_shared/utils/response.ts";

async function generateHMSJoinToken(
  accessKey: string,
  secret: string,
  roomId: string,
  userId: string,
  role: string
): Promise<string> {
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
    type: "app",
    version: 2,
    room_id: roomId,
    user_id: userId,
    role: role,
    iat: Math.floor(Date.now() / 1000),
    exp: Math.floor(Date.now() / 1000) + 24 * 60 * 60, // 24 hours expiry
    nbf: Math.floor(Date.now() / 1000)
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

      const { meetingId } = await req.json();

      if (!meetingId) {
        return errorResponse("Missing required field: meetingId");
      }

      const userId = ctx.userClaims.sub || ctx.userClaims.id;
      if (!userId) {
        return errorResponse("Unauthorized: Could not determine user ID", 401);
      }

      // 1. Fetch user profile and companyId
      const { data: userProfile, error: profileError } = await ctx.supabaseAdmin
        .from("profiles")
        .select("*")
        .eq("id", userId)
        .single();

      if (profileError || !userProfile) {
        return errorResponse(`Could not fetch user profile: ${profileError?.message || "Profile not found"}`, 404);
      }

      // 2. Fetch meeting record
      const { data: meeting, error: meetingError } = await ctx.supabaseAdmin
        .from("meetings")
        .select("*")
        .eq("id", meetingId)
        .single();

      if (meetingError || !meeting) {
        return errorResponse(`Could not fetch meeting: ${meetingError?.message || "Meeting not found"}`, 404);
      }

      // 3. Enforce tenant isolation (same company check)
      if (meeting.company_id !== userProfile.company_id) {
        return errorResponse("Forbidden: You do not belong to the company hosting this meeting", 403);
      }

      // 4. Map user role to 100ms role (leader -> host, member -> guest)
      const mappedRole = userProfile.role === "leader" ? "host" : "guest";

      // 5. Generate token using HMS credentials or return mock token
      const accessKey = Deno.env.get("HMS_ACCESS_KEY");
      const secretKey = Deno.env.get("HMS_SECRET");
      let token = "";

      if (accessKey && secretKey) {
        const roomId = meeting.room_id || "mock-room-id";
        token = await generateHMSJoinToken(accessKey, secretKey, roomId, userId, mappedRole);
      } else {
        // Fallback for local development or testing without HMS keys
        const mockPayload = {
          role: mappedRole,
          userId,
          meetingId,
          roomId: meeting.room_id || "mock-room-id"
        };
        token = `mock-token-${btoa(JSON.stringify(mockPayload)).replace(/=/g, "")}`;
        console.log(`HMS credentials missing. Generated local development mock token for role: ${mappedRole}`);
      }

      return successResponse({ token }, 200);
    } catch (err: any) {
      return errorResponse(err.message || "Internal server error", 500);
    }
  }),
};
