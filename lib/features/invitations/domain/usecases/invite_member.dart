import '../entities/invitation.dart';
import '../repositories/invitation_repository.dart';

/// Use case for a leader inviting a new member to their organization.
///
/// This is the entry point for every new member in Distributor OS.
/// The flow:
///
///   Leader fills in: Distributor ID, Name, Phone
///     → This use case validates inputs
///     → Repository handles: uniqueness checks, plan limit, profile creation
///     → Returns the created [Invitation]
///
/// The repository (data layer) is responsible for:
///   - Checking distributor ID uniqueness within the company
///   - Checking phone uniqueness within the company
///   - Checking the leader's subscription plan limit
///   - Creating the profile with status = 'invited'
///   - Creating the invitation record with status = 'pending'
///
/// This use case only handles domain-level input validation.
class InviteMemberUseCase {
  final InvitationRepository _repository;

  InviteMemberUseCase(this._repository);

  Future<Invitation> call({
    required String inviterId,
    required String distributorId,
    required String fullName,
    required String phone,
    required String companyId,
  }) async {
    // ── Input validation (domain rules) ──────────────────────────
    if (inviterId.trim().isEmpty) {
      throw ArgumentError('Inviter ID cannot be empty');
    }
    if (distributorId.trim().isEmpty) {
      throw ArgumentError('Distributor ID cannot be empty');
    }
    if (fullName.trim().isEmpty) {
      throw ArgumentError('Full name cannot be empty');
    }
    if (phone.trim().isEmpty) {
      throw ArgumentError('Phone number cannot be empty');
    }
    if (companyId.trim().isEmpty) {
      throw ArgumentError('Company ID cannot be empty');
    }

    return _repository.inviteMember(
      inviterId: inviterId.trim(),
      distributorId: distributorId.trim(),
      fullName: fullName.trim(),
      phone: phone.trim(),
      companyId: companyId.trim(),
    );
  }
}
