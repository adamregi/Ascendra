import '../entities/authenticated_user.dart';
import '../repositories/auth_repository.dart';

/// Signs in a user with their Distributor ID and password.
///
/// This is the primary authentication flow for returning users.
///
/// Flow:
///   1. UI collects distributor ID + password
///   2. This use case delegates to [AuthRepository]
///   3. Repository authenticates against Supabase Auth
///   4. Repository fetches the profile from the `profiles` table
///   5. Returns [AuthenticatedUser] (business identity)
///
/// Throws if credentials are invalid or the network is unreachable.
class SignInWithPasswordUseCase {
  final AuthRepository _repository;

  SignInWithPasswordUseCase(this._repository);

  Future<AuthenticatedUser> call({
    required String distributorId,
    required String password,
  }) async {
    // ── Input validation (domain rules) ──────────────────────────
    if (distributorId.trim().isEmpty) {
      throw ArgumentError('Distributor ID cannot be empty');
    }
    if (password.isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }

    return _repository.signInWithPassword(
      distributorId: distributorId.trim(),
      password: password,
    );
  }
}
