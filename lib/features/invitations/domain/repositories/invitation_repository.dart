import '../entities/invitation.dart';

/// Abstract contract for invitation operations.
///
/// The domain layer defines WHAT can be done.
/// The data layer (Supabase) defines HOW it's done.
///
/// No Supabase. No Riverpod. No implementation details.
abstract class InvitationRepository {
  /// Create a new invitation from a leader to a prospective member.
  ///
  /// The implementation must:
  ///   1. Validate uniqueness of [distributorId] within the company
  ///   2. Validate uniqueness of [phone] within the company
  ///   3. Check the leader's subscription plan limit
  ///   4. Create a profile with status = 'invited'
  ///   5. Create the invitation record with status = 'pending'
  ///   6. Return the created [Invitation]
  ///
  /// Throws if any validation fails or the network is unreachable.
  Future<Invitation> inviteMember({
    required String inviterId,
    required String distributorId,
    required String fullName,
    required String phone,
    required String companyId,
  });

  /// Accept a pending invitation.
  ///
  /// Called after the member completes OTP verification + password creation.
  /// The implementation must:
  ///   1. Create the Supabase auth user
  ///   2. Link `auth_user_id` to the existing profile
  ///   3. Set profile status = 'active'
  ///   4. Set invitation status = 'accepted'
  ///
  /// Throws if the invitation is not pending, expired, or already accepted.
  Future<Invitation> acceptInvitation({required String invitationId});

  /// Cancel a pending invitation.
  ///
  /// Only the leader who created the invitation can cancel it.
  /// The implementation should also clean up the 'invited' profile.
  ///
  /// Throws if the invitation is not in a cancellable state.
  Future<void> cancelInvitation({required String invitationId});

  /// Get a single invitation by its ID.
  ///
  /// Used when a member opens the invitation link.
  /// Returns `null` if the invitation does not exist.
  Future<Invitation?> getInvitation({required String invitationId});

  /// Get all invitations created by a specific leader.
  ///
  /// Used on the leader's "Invited Members" screen.
  /// Returns invitations in all statuses (pending, accepted, cancelled, expired).
  Future<List<Invitation>> getInvitationsByInviter({required String inviterId});

  /// Get all pending invitations for a specific company.
  ///
  /// Used for admin dashboards and plan limit calculations.
  Future<List<Invitation>> getPendingInvitations({required String companyId});
}
