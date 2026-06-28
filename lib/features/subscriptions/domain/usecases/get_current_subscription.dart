import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

/// Use case for retrieving a leader's current subscription.
///
/// Used by:
///   - Dashboard to show plan name and status
///   - Feature gates to check AI / analytics access
///   - Invite flow to check if subscription is active
///
/// Returns `null` if no active subscription exists.
/// In that case, the UI should show the plan selection screen.
class GetCurrentSubscriptionUseCase {
  final SubscriptionRepository _repository;

  GetCurrentSubscriptionUseCase(this._repository);

  Future<Subscription?> call({required String leaderId}) async {
    if (leaderId.trim().isEmpty) {
      throw ArgumentError('Leader ID cannot be empty');
    }

    return _repository.getCurrentSubscription(leaderId: leaderId.trim());
  }
}
