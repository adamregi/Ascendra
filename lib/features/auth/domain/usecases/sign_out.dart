import '../repositories/auth_repository.dart';

/// Signs out the current user and destroys the session.
///
/// After sign-out:
///   - The auth state stream emits `null`
///   - The router redirects to the login screen
///   - Local session data is cleared (by the data layer)
///
/// This use case is the single exit point for authentication.
/// Any cleanup (cache clearing, analytics reset) can be
/// orchestrated here as the domain grows.
class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> call() async {
    return _repository.signOut();
  }
}
