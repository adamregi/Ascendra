import '../entities/invitation.dart';
import '../repositories/invitation_repository.dart';

/// Use case for a member accepting a pending invitation.
///
/// Called after the member:
///   1. Opens the invitation link
///   2. Verifies OTP on their phone
///   3. Creates their password
///
/// The repository (data layer) handles the rest:
///   - Create Supabase auth user with phone + password
///   - Link `auth_user_id` to the existing profile
///   - Set profile status → active
///   - Set invitation status → accepted
///
/// Returns the updated [Invitation] with status = accepted.
/// Throws if the invitation is not pending, expired, or doesn't exist.
class AcceptInvitationUseCase {
  final InvitationRepository _repository;

  AcceptInvitationUseCase(this._repository);

  Future<Invitation> call({required String invitationId}) async {
    if (invitationId.trim().isEmpty) {
      throw ArgumentError('Invitation ID cannot be empty');
    }

    return _repository.acceptInvitation(invitationId: invitationId.trim());
  }
}
