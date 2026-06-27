import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

/// Use case for upgrading a leader's subscription to a higher plan.
///
/// Business rules enforced:
///   - Only upgrades are allowed (higher member limit)
///   - Downgrades are blocked (would require removing members)
///   - Subscription must be active to upgrade
///   - All existing members and invitations are preserved
///
/// The repository (data layer) verifies:
///   - The new plan exists
///   - The new plan has a higher member limit
///   - The subscription is in an upgradeable state
///
/// Returns the updated [Subscription] with the new plan.
class UpgradeSubscriptionUseCase {
  final SubscriptionRepository _repository;

  UpgradeSubscriptionUseCase(this._repository);

  Future<Subscription> call({
    required String subscriptionId,
    required String newPlanId,
  }) async {
    if (subscriptionId.trim().isEmpty) {
      throw ArgumentError('Subscription ID cannot be empty');
    }
    if (newPlanId.trim().isEmpty) {
      throw ArgumentError('New plan ID cannot be empty');
    }

    return _repository.upgradeSubscription(
      subscriptionId: subscriptionId.trim(),
      newPlanId: newPlanId.trim(),
    );
  }
}
