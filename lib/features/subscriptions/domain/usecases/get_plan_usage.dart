import '../entities/plan_usage.dart';
import '../repositories/subscription_repository.dart';

/// Use case for retrieving a leader's current plan usage.
///
/// Returns a computed [PlanUsage] object showing:
///   - limit: maximum members allowed by the plan
///   - activeMembers: members with status = active
///   - invitedMembers: members with status = invited
///   - used: activeMembers + invitedMembers
///   - available: limit - used
///
/// Used by:
///   - Dashboard to show "43 / 50 members used" with a progress bar
///   - Invite flow to show remaining slots before the form
///   - Settings page to show plan utilization
///
/// The [PlanUsage.usageRatio] field (0.0 to 1.0) is ready
/// for direct use in a progress bar widget.
class GetPlanUsageUseCase {
  final SubscriptionRepository _repository;

  GetPlanUsageUseCase(this._repository);

  Future<PlanUsage> call({required String leaderId}) async {
    if (leaderId.trim().isEmpty) {
      throw ArgumentError('Leader ID cannot be empty');
    }

    return _repository.getPlanUsage(leaderId: leaderId.trim());
  }
}
