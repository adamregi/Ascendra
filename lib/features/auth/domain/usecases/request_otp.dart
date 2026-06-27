import '../repositories/auth_repository.dart';

/// Requests a one-time password sent to the given phone number.
///
/// This is the first step of the OTP authentication flow:
///   1. User enters their phone number
///   2. This use case sends the OTP request
///   3. User receives SMS with the code
///   4. User enters the code → [VerifyOtpUseCase]
///
/// Does NOT return user data — the user must call verify next.
/// Throws on invalid phone format or network failure.
class RequestOtpUseCase {
  final AuthRepository _repository;

  RequestOtpUseCase(this._repository);

  Future<void> call({required String phone}) async {
    // ── Input validation (domain rules) ──────────────────────────
    final normalized = phone.trim();
    if (normalized.isEmpty) {
      throw ArgumentError('Phone number cannot be empty');
    }

    // TODO: Add phone number format validation for Indian numbers
    // e.g., must start with +91, must be 13 chars total

    return _repository.requestOtp(phone: normalized);
  }
}
