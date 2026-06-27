/// Computed value object representing a leader's plan usage.
///
/// This is NOT stored in the database — it is computed from:
///   - Count of active members under this leader
///   - Count of invited profiles (pending acceptance) under this leader
///
/// Usage formula:
///   used = activeMembers + invitedMembers
///   available = limit - used
///
/// Example:
///   Plan: Starter (limit = 50)
///   Active Members: 20
///   Invited Members: 23
///   Used: 43
///   Available: 7
///
/// This object is returned by the repository, not constructed by the UI.
class PlanUsage {
  /// The plan's maximum member limit.
  final int limit;

  /// Number of active members under this leader.
  final int activeMembers;

  /// Number of invited members (pending acceptance) under this leader.
  final int invitedMembers;

  const PlanUsage({
    required this.limit,
    required this.activeMembers,
    required this.invitedMembers,
  });

  /// Total slots consumed (active + invited).
  int get used => activeMembers + invitedMembers;

  /// Remaining available slots.
  int get available => limit - used;

  /// Whether the plan limit has been reached.
  bool get isAtLimit => used >= limit;

  /// Whether there is room for at least one more invitation.
  bool get canInvite => available > 0;

  /// Usage as a fraction (0.0 to 1.0+).
  ///
  /// Useful for progress bars in the UI.
  /// Can exceed 1.0 if somehow over-provisioned (defensive).
  double get usageRatio => limit > 0 ? used / limit : 1.0;
}
