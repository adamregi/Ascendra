import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provides the single [SupabaseClient] instance to the entire app.
///
/// Usage in any widget / provider:
/// ```dart
/// final client = ref.read(supabaseClientProvider);
/// ```
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});
