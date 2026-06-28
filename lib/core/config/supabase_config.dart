/// Supabase project configuration.
///
/// Get these values from your Supabase dashboard:
///   Settings → API → Project URL & anon public key.
class SupabaseConfig {
  SupabaseConfig._(); // Prevent instantiation

  /// Project URL from Settings → API
  static const String url = 'http://192.168.0.4:54321';

  /// Anon / public key from Settings → API
  static const String anonKey =
      'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH';
}
