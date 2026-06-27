import 'invitation_status.dart';

/// Domain entity representing an invitation from a leader to a prospective member.
///
/// Maps to the `invitations` table:
///   id, inviter_id, distributor_id, full_name, phone,
///   company_id, status, invited_at, accepted_at, expires_at
///
/// An invitation is the entry point for every new member in the system.
/// The flow is:
///
///   Leader creates invitation (status = pending)
///     → SMS/WhatsApp sent to the prospective member
///     → Member opens link, verifies OTP, sets password
///     → Supabase auth user created, profile linked
///     → Invitation status = accepted, profile status = active
///
/// Business rules enforced before invitation creation:
///   - Distributor ID must be unique across the company
///   - Phone must be unique across the company
///   - Leader's subscription plan limit must not be exceeded
///
/// This is a pure domain object — no Supabase imports, no JSON logic.
class Invitation {
  /// Unique identifier for this invitation (UUID).
  final String id;

  /// The leader who created this invitation.
  final String inviterId;

  /// The distributor ID assigned to the prospective member.
  ///
  /// This is pre-assigned by the leader at invitation time,
  /// NOT chosen by the member during onboarding.
  final String distributorId;

  /// The prospective member's full name.
  final String fullName;

  /// The prospective member's phone number (for OTP verification).
  final String phone;

  /// The company this invitation belongs to.
  final String companyId;

  /// The current status of this invitation.
  final InvitationStatus status;

  /// When this invitation was created.
  final DateTime invitedAt;

  /// When this invitation was accepted (null if still pending).
  final DateTime? acceptedAt;

  /// When this invitation expires (null if no expiry policy).
  final DateTime? expiresAt;

  const Invitation({
    required this.id,
    required this.inviterId,
    required this.distributorId,
    required this.fullName,
    required this.phone,
    required this.companyId,
    required this.status,
    required this.invitedAt,
    this.acceptedAt,
    this.expiresAt,
  });

  // ── Domain queries ─────────────────────────────────────────────

  /// Whether this invitation can still be acted upon by the member.
  bool get isPending => status == InvitationStatus.pending;

  /// Whether this invitation has been accepted.
  bool get isAccepted => status == InvitationStatus.accepted;

  /// Whether this invitation was cancelled by the leader.
  bool get isCancelled => status == InvitationStatus.cancelled;

  /// Whether this invitation has expired.
  bool get isExpired {
    if (status == InvitationStatus.expired) return true;
    if (expiresAt != null && DateTime.now().isAfter(expiresAt!)) return true;
    return false;
  }

  /// Whether this invitation can still be cancelled by the leader.
  ///
  /// Only pending invitations can be cancelled — once accepted,
  /// cancelled, or expired, the invitation is in a terminal state.
  bool get isCancellable => status == InvitationStatus.pending;
}
