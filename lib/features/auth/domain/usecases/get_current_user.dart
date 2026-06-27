import '../entities/authenticated_user.dart';
import '../repositories/auth_repository.dart';

/// Retrieves the currently authenticated user, if any.
///
/// Used on app startup and after navigation to determine:
///   - Is there an active session?       → user != null
///   - What role does the user have?     → user.role
///   - Are they in good standing?        → user.isActive
///
/// Returns `null` when no active session exists (→ redirect to login).
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<AuthenticatedUser?> call() async {
    return _repository.getCurrentUser();
  }
}
