import { SupabaseClient } from "npm:@supabase/supabase-js@^2";

export interface AuditLogEntry {
  companyId: string;
  actorId: string | null;
  targetId?: string | null;
  action: string;
  entityType: string;
  before?: Record<string, unknown> | null;
  after?: Record<string, unknown> | null;
  ipAddress?: string | null;
  userAgent?: string | null;
}

/**
 * Inserts an audit log entry using the service-role Supabase client.
 * Failures are logged but never throw — audit logging must not break
 * the primary operation.
 */
export async function logAudit(
  admin: SupabaseClient,
  entry: AuditLogEntry
): Promise<void> {
  const { error } = await admin
    .from("audit_logs")
    .insert({
      company_id: entry.companyId,
      actor_id: entry.actorId,
      target_id: entry.targetId ?? null,
      action: entry.action,
      entity_type: entry.entityType,
      before_data: entry.before ?? null,
      after_data: entry.after ?? null,
      ip_address: entry.ipAddress ?? null,
      user_agent: entry.userAgent ?? null,
    });

  if (error) {
    console.error(
      `[audit] Failed to log: ${entry.entityType}.${entry.action} — ${error.message}`
    );
  }
}
