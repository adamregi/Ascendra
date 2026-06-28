import '../entities/invitation.dart';
import '../repositories/invitation_repository.dart';

/// Use case for retrieving a single invitation by its ID.
///
/// Primary use cases:
///   - Member opens the invitation link → fetch invitation details
///   - Leader views a specific invitation's status
///
/// Returns `null` if the invitation does not exist.
class GetInvitationUseCase {
  final InvitationRepository _repository;

  GetInvitationUseCase(this._repository);

  Future<Invitation?> call({required String invitationId}) async {
    if (invitationId.trim().isEmpty) {
      throw ArgumentError('Invitation ID cannot be empty');
    }

    return _repository.getInvitation(invitationId: invitationId.trim());
  }
}
