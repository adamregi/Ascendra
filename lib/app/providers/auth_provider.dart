
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_provider.dart';

/// Streams the current Supabase [AuthState] (sign-in, sign-out, token refresh).
///
/// The router listens to this to decide: Login or Dashboard.
final authStateProvider = StreamProvider<AuthState>((ref) {
  final client = ref.read(supabaseClientProvider);
  return client.auth.onAuthStateChange;
});
