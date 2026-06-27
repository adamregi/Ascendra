import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/authenticated_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/profile_model.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final supabase.SupabaseClient _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<AuthenticatedUser> signInWithPassword({
    required String distributorId,
    required String password,
  }) async {
    try {
      // 1. Resolve distributor_id to email using secure RPC
      final email = await _client.rpc(
        'resolve_distributor_login',
        params: {'p_distributor_id': distributorId},
      ) as String?;

      if (email == null || email.trim().isEmpty) {
        throw supabase.AuthException('Distributor ID not found');
      }

      // 2. Perform sign-in with GoTrue using email + password
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw supabase.AuthException('Authentication failed: user is null');
      }

      // 3. Fetch user profile
      final profile = await _fetchProfile(response.user!.id);
      return AuthenticatedUser(profile: profile);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> requestOtp({required String phone}) async {
    try {
      await _client.auth.signInWithOtp(
        phone: phone,
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<AuthenticatedUser> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _client.auth.verifyOTP(
        phone: phone,
        token: code,
        type: supabase.OtpType.sms,
      );

      if (response.user == null) {
        throw supabase.AuthException('OTP verification failed: user is null');
      }

      final profile = await _fetchProfile(response.user!.id);
      return AuthenticatedUser(profile: profile);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<AuthenticatedUser?> getCurrentUser() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return null;

      final profile = await _fetchProfile(user.id);
      return AuthenticatedUser(profile: profile);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Stream<AuthenticatedUser?> authStateChanges() {
    return _client.auth.onAuthStateChange.asyncMap((state) async {
      final user = state.session?.user;
      if (user == null) return null;
      try {
        final profile = await _fetchProfile(user.id);
        return AuthenticatedUser(profile: profile);
      } catch (_) {
        return null;
      }
    });
  }

  Future<ProfileModel> _fetchProfile(String userId) async {
    final data = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return ProfileModel.fromJson(data);
  }
}
