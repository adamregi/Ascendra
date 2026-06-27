/// The lifecycle status of an invitation.
///
/// Matches the database constraint:
///   `check (status in ('pending', 'accepted', 'cancelled', 'expired'))`
///
/// Lifecycle:
///
///   [pending]    → invitation created, awaiting member action
///   [accepted]   → member completed OTP + password, now active
///   [cancelled]  → leader withdrew the invitation before acceptance
///   [expired]    → invitation timed out (e.g. 7 days without action)
///
/// State transitions:
///
///   pending → accepted    (member completes onboarding)
///   pending → cancelled   (leader cancels before acceptance)
///   pending → expired     (time limit exceeded — enforced by backend)
///
/// Terminal states: [accepted], [cancelled], [expired] — no further transitions.
enum InvitationStatus {
  pending,
  accepted,
  cancelled,
  expired;

  /// Deserialize from the database `status` text column.
  static InvitationStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return InvitationStatus.pending;
      case 'accepted':
        return InvitationStatus.accepted;
      case 'cancelled':
        return InvitationStatus.cancelled;
      case 'expired':
        return InvitationStatus.expired;
      default:
        throw ArgumentError('Unknown InvitationStatus: $value');
    }
  }

  /// Serialize back to the database text value.
  String toJson() => name;

  /// Whether the invitation is still actionable by the member.
  bool get isActionable => this == pending;
}
