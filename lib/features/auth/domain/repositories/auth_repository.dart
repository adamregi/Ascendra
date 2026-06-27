import '../entities/authenticated_user.dart';

/// Abstract contract for authentication operations.
///
/// The domain layer defines WHAT can be done.
/// The data layer (Supabase) defines HOW it's done.
///
/// No Supabase. No Riverpod. No implementation details.
abstract class AuthRepository {
  /// Sign in with email + password.
  ///
  /// Returns the [AuthenticatedUser] on success.
  /// Throws on invalid credentials or network failure.
  Future<AuthenticatedUser> signInWithPassword({
    required String distributorId,
    required String password,
  });

  /// Request a one-time password sent to [phone].
  ///
  /// Does not return user data — the user must call [verifyOtp] next.
  Future<void> requestOtp({required String phone});

  /// Verify the OTP code sent to [phone].
  ///
  /// Returns the [AuthenticatedUser] on success.
  /// Throws if the code is invalid or expired.
  Future<AuthenticatedUser> verifyOtp({
    required String phone,
    required String code,
  });

  /// Get the currently authenticated user, if any.
  ///
  /// Returns `null` when no active session exists.
  Future<AuthenticatedUser?> getCurrentUser();

  /// Sign out the current user and destroy the session.
  Future<void> signOut();

  /// Stream of auth state changes (sign-in, sign-out, token refresh).
  ///
  /// The router listens to this to decide: Login or Dashboard.
  Stream<AuthenticatedUser?> authStateChanges();
}
