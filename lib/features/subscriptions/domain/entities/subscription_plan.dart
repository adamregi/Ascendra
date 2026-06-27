/// Domain entity representing a subscription plan tier.
///
/// Maps to the `subscription_plans` table:
///   id, name, member_limit, ai_enabled, analytics_enabled
///
/// Current plans:
///
///   ┌─────────────┬───────────────┬────────────┬───────────────────┐
///   │ Plan        │ Member Limit  │ AI Enabled │ Analytics Enabled │
///   ├─────────────┼───────────────┼────────────┼───────────────────┤
///   │ Starter     │ 50            │ ✅          │ ❌                 │
///   │ Pro         │ 100           │ ✅          │ ✅                 │
///   │ Enterprise  │ 200           │ ✅          │ ✅                 │
///   └─────────────┴───────────────┴────────────┴───────────────────┘
///
/// Future: Custom plans with arbitrary limits can be added
/// without changing this entity — just add rows to the database.
///
/// This is a pure domain object — no Supabase imports, no JSON logic.
class SubscriptionPlan {
  /// Unique identifier for this plan (UUID or slug).
  final String id;

  /// Human-readable plan name (e.g. 'Starter', 'Pro', 'Enterprise').
  final String name;

  /// Maximum number of members allowed under this plan.
  ///
  /// Usage is calculated as:
  ///   active members + invited members (pending acceptance)
  ///
  /// This means invitations consume slots immediately,
  /// not only after the member accepts.
  final int memberLimit;

  /// Whether AI features are available on this plan.
  final bool aiEnabled;

  /// Whether analytics dashboards are available on this plan.
  final bool analyticsEnabled;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.memberLimit,
    required this.aiEnabled,
    required this.analyticsEnabled,
  });

  /// Whether this plan supports a higher member limit than [other].
  ///
  /// Used to determine if an upgrade is possible.
  bool isUpgradeFrom(SubscriptionPlan other) =>
      memberLimit > other.memberLimit;

  /// Whether moving to this plan from [current] would be a downgrade.
  ///
  /// Downgrades are blocked to prevent messy automatic member removal.
  bool isDowngradeFrom(SubscriptionPlan current) =>
      memberLimit < current.memberLimit;
}
