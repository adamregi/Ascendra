import '../repositories/subscription_repository.dart';

/// Use case for checking whether a leader can invite one more member.
///
/// This is the gate that runs before every invitation:
///
///   Leader presses "Invite Member"
///     → CanInviteMember checks:
///       1. Is the subscription active?
///       2. Is current usage < member limit?
///     → If both true: allow
///     → If either false: reject
///
/// Usage calculation:
///   used = active members + invited members (pending)
///   available = plan.memberLimit - used
///
/// Example:
///   Plan: Starter (limit = 50)
///   Active: 20, Invited: 30
///   Used: 50 / 50
///   Result: false (cannot invite)
///
/// This use case is intentionally separate from InviteMember
/// so the UI can check eligibility before showing the invite form.
class CanInviteMemberUseCase {
  final SubscriptionRepository _repository;

  CanInviteMemberUseCase(this._repository);

  Future<bool> call({required String leaderId}) async {
    if (leaderId.trim().isEmpty) {
      throw ArgumentError('Leader ID cannot be empty');
    }

    return _repository.canInviteMember(
      leaderId: leaderId.trim(),
    );
  }
}
