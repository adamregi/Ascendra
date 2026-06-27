/**
 * Input validation helpers for edge functions.
 * All validators throw descriptive errors on failure.
 */

const UUID_REGEX =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

/** Throws if any of the named fields are nullish or empty strings. */
export function validateRequired(
  fields: Record<string, unknown>
): void {
  const missing: string[] = [];
  for (const [name, value] of Object.entries(fields)) {
    if (value === undefined || value === null || value === "") {
      missing.push(name);
    }
  }
  if (missing.length > 0) {
    throw new Error(`Missing required field(s): ${missing.join(", ")}`);
  }
}

/** Throws if the value is not a valid UUID v4 string. */
export function validateUUID(value: string, fieldName = "id"): void {
  if (!UUID_REGEX.test(value)) {
    throw new Error(`Invalid UUID for ${fieldName}: ${value}`);
  }
}

/** Throws if the value is not a plausible email address. */
export function validateEmail(value: string, fieldName = "email"): void {
  if (!EMAIL_REGEX.test(value)) {
    throw new Error(`Invalid email for ${fieldName}: ${value}`);
  }
}

/**
 * Trims and sanitises a string value.
 * Removes leading/trailing whitespace and collapses internal runs of
 * whitespace to a single space.  Returns the cleaned string.
 */
export function sanitizeString(value: string): string {
  return value.trim().replace(/\s+/g, " ");
}

/**
 * Generates a URL-safe slug from a string.
 * Lowercases, replaces spaces/special chars with hyphens, collapses
 * consecutive hyphens, and strips leading/trailing hyphens.
 */
export function generateSlug(value: string): string {
  return value
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9\s-]/g, "")
    .replace(/[\s]+/g, "-")
    .replace(/-+/g, "-")
    .replace(/^-|-$/g, "");
}
