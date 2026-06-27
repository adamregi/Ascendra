import { SupabaseClient } from "npm:@supabase/supabase-js@^2";

export async function verifyUser(supabase: SupabaseClient, authHeader?: string) {
  if (!authHeader) {
    throw new Error("Missing Authorization header");
  }
  const token = authHeader.replace(/^Bearer\s+/i, "").trim();
  if (!token) {
    throw new Error("Invalid Authorization token format");
  }
  const { data: { user }, error } = await supabase.auth.getUser(token);
  if (error || !user) {
    throw new Error(error?.message || "Invalid user token");
  }
  return user;
}
