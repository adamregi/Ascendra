import '../entities/plan_usage.dart';
import '../entities/subscription.dart';
import '../entities/subscription_plan.dart';

/// Abstract contract for subscription operations.
///
/// The domain layer defines WHAT can be done.
/// The data layer (Supabase) defines HOW it's done.
///
/// No Supabase. No Riverpod. No implementation details.
abstract class SubscriptionRepository {
  /// Get the currently active subscription for a leader.
  ///
  /// Returns `null` if the leader has no active subscription
  /// (e.g. first-time leader, or subscription expired/cancelled).
  ///
  /// Business rule: one leader = one active subscription.
  Future<Subscription?> getCurrentSubscription({required String leaderId});

  /// Get all available subscription plans.
  ///
  /// Returns the full catalog of plans (Starter, Pro, Enterprise).
  /// Used on the plan selection / upgrade screen.
  Future<List<SubscriptionPlan>> getAvailablePlans();

  /// Upgrade a leader's subscription to a higher plan.
  ///
  /// The implementation must:
  ///   1. Verify the new plan is an upgrade (higher member limit)
  ///   2. Reject downgrades (lower member limit)
  ///   3. Preserve all existing members and invitations
  ///   4. Update the subscription record with the new plan
  ///
  /// Returns the updated [Subscription] with the new plan.
  /// Throws if the plan change is a downgrade or the subscription
  /// is not active.
  Future<Subscription> upgradeSubscription({
    required String subscriptionId,
    required String newPlanId,
  });

  /// Get the computed plan usage for a leader.
  ///
  /// Returns a [PlanUsage] object with:
  ///   - limit (from the subscription plan)
  ///   - activeMembers (count from profiles where status = active)
  ///   - invitedMembers (count from profiles where status = invited)
  ///
  /// This is the data needed to gate invitation creation.
  Future<PlanUsage> getPlanUsage({required String leaderId});

  /// Check whether a leader can invite one more member.
  ///
  /// Convenience method that combines:
  ///   - Is the subscription active?
  ///   - Is the plan usage below the limit?
  ///
  /// Returns `true` if the invitation is allowed.
  /// Returns `false` if the plan is at capacity or the
  /// subscription is not active.
  Future<bool> canInviteMember({required String leaderId});
}
