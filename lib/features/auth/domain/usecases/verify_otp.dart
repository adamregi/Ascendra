import '../entities/authenticated_user.dart';
import '../repositories/auth_repository.dart';

/// Verifies an OTP code sent to the given phone number.
///
/// This is the second step of the OTP authentication flow:
///   1. [RequestOtpUseCase] sends the code
///   2. User enters the received code
///   3. This use case verifies it against the auth provider
///   4. Returns [AuthenticatedUser] on success
///
/// Throws if the code is invalid, expired, or the network is unreachable.
class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<AuthenticatedUser> call({
    required String phone,
    required String code,
  }) async {
    // ── Input validation (domain rules) ──────────────────────────
    if (phone.trim().isEmpty) {
      throw ArgumentError('Phone number cannot be empty');
    }
    if (code.trim().isEmpty) {
      throw ArgumentError('OTP code cannot be empty');
    }

    return _repository.verifyOtp(phone: phone.trim(), code: code.trim());
  }
}
