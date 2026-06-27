import '../repositories/invitation_repository.dart';

/// Use case for a leader cancelling a pending invitation.
///
/// Only pending invitations can be cancelled. Once an invitation
/// has been accepted, expired, or already cancelled, this will throw.
///
/// The repository (data layer) should also clean up:
///   - Set invitation status → cancelled
///   - Remove or mark the 'invited' profile as cancelled
///
/// This is an irreversible action — the leader must create
/// a new invitation if they want to re-invite the same person.
class CancelInvitationUseCase {
  final InvitationRepository _repository;

  CancelInvitationUseCase(this._repository);

  Future<void> call({required String invitationId}) async {
    if (invitationId.trim().isEmpty) {
      throw ArgumentError('Invitation ID cannot be empty');
    }

    return _repository.cancelInvitation(
      invitationId: invitationId.trim(),
    );
  }
}
