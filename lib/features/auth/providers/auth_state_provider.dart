import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/auth_repository.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<AuthState> authState(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
}

@riverpod
User? currentUser(Ref ref) {
  final authState = ref.watch(authStateProvider).value;
  return authState?.session?.user;
}
