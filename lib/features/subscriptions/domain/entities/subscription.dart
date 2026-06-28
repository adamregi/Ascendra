import 'subscription_plan.dart';
import 'subscription_status.dart';

/// Domain entity representing a leader's subscription.
///
/// Maps to the `subscriptions` table:
///   id, leader_id, plan_id, status, started_at, expires_at,
///   cancelled_at, created_at, updated_at
///
/// Business rules:
///
///   1. One leader = ONE active subscription (no stacking)
///   2. Upgrade (50→100) preserves everything
///   3. Downgrade (100→50) is blocked
///   4. Expiry restricts features but allows login + renew
///
/// This is a pure domain object — no Supabase imports, no JSON logic.
class Subscription {
  /// Unique identifier for this subscription (UUID).
  final String id;

  /// The leader who owns this subscription.
  final String leaderId;

  /// The plan this subscription is on.
  final SubscriptionPlan plan;

  /// The current status of this subscription.
  final SubscriptionStatus status;

  /// When this subscription started.
  final DateTime startedAt;

  /// When this subscription expires (end of billing period).
  final DateTime expiresAt;

  /// When this subscription was cancelled (null if not cancelled).
  final DateTime? cancelledAt;

  const Subscription({
    required this.id,
    required this.leaderId,
    required this.plan,
    required this.status,
    required this.startedAt,
    required this.expiresAt,
    this.cancelledAt,
  });

  // ── Domain queries ─────────────────────────────────────────────

  /// Whether this subscription currently grants access to features.
  bool get isActive => status == SubscriptionStatus.active;

  /// Whether this subscription has expired.
  bool get isExpired => status == SubscriptionStatus.expired;

  /// Whether this subscription was cancelled.
  bool get isCancelled => status == SubscriptionStatus.cancelled;

  /// Whether this subscription is past its expiry date.
  ///
  /// This checks the actual time, not the status field.
  /// Useful for catching expired subscriptions before the backend
  /// cron job updates the status.
  bool get isPastExpiry => DateTime.now().isAfter(expiresAt);

  /// Whether upgrading to [newPlan] is allowed.
  ///
  /// Upgrades are allowed: higher member limit.
  /// Downgrades are blocked: would require removing members.
  bool canUpgradeTo(SubscriptionPlan newPlan) => newPlan.isUpgradeFrom(plan);

  /// The member limit from the current plan.
  int get memberLimit => plan.memberLimit;

  /// Whether AI features are available on the current plan.
  bool get hasAiAccess => plan.aiEnabled && isActive;

  /// Whether analytics are available on the current plan.
  bool get hasAnalyticsAccess => plan.analyticsEnabled && isActive;
}
