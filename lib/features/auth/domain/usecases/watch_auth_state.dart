import '../entities/authenticated_user.dart';
import '../repositories/auth_repository.dart';

/// Watches authentication state changes as a reactive stream.
///
/// Emits:
///   - [AuthenticatedUser] when a user signs in or the session refreshes
///   - `null` when the user signs out or the session expires
///
/// The app router listens to this stream to decide:
///   - `user != null`  → navigate to Dashboard
///   - `user == null`  → navigate to Login
///
/// This is the single source of truth for "is someone logged in?"
class WatchAuthStateUseCase {
  final AuthRepository _repository;

  WatchAuthStateUseCase(this._repository);

  Stream<AuthenticatedUser?> call() {
    return _repository.authStateChanges();
  }
}
