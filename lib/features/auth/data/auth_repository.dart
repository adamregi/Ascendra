import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/failures/failure.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  Future<String> _resolveEmail(String distributorId) async {
    try {
      final response = await _supabase.rpc('resolve_distributor_login', params: {'p_distributor_id': distributorId});
      if (response == null || response.toString().isEmpty) {
        throw const AuthFailure(message: 'Distributor ID not found', code: 'not_found');
      }
      return response.toString();
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw UnknownFailure(message: 'Failed to resolve Distributor ID: $e');
    }
  }

  Future<AuthResponse> signInWithPasswordMode(String distributorId, String password) async {
    try {
      final email = await _resolveEmail(distributorId);
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message, code: e.statusCode);
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw UnknownFailure(message: e.toString());
    }
  }

  Future<void> sendOtp(String distributorId) async {
    try {
      final email = await _resolveEmail(distributorId);
      await _supabase.auth.signInWithOtp(email: email);
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message, code: e.statusCode);
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw UnknownFailure(message: e.toString());
    }
  }

  Future<AuthResponse> verifyOtp(String distributorId, String otp) async {
    try {
      final email = await _resolveEmail(distributorId);
      final response = await _supabase.auth.verifyOTP(
        type: OtpType.magiclink,
        email: email,
        token: otp,
      );
      return response;
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message, code: e.statusCode);
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw UnknownFailure(message: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message, code: e.statusCode);
    } catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
  
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(Supabase.instance.client);
}
