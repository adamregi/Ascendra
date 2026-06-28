import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/plan_usage.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_plan.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../models/plan_usage_model.dart';
import '../models/subscription_model.dart';
import '../models/subscription_plan_model.dart';

class SubscriptionRepositoryImpl extends BaseRepository
    implements SubscriptionRepository {
  final supabase.SupabaseClient _client;

  SubscriptionRepositoryImpl(this._client);

  @override
  Future<Subscription?> getCurrentSubscription({
    required String leaderId,
  }) async {
    try {
      final data =
          await _client
              .from('subscriptions')
              .select('*, plan:subscription_plans(*)')
              .eq('leader_id', leaderId)
              .eq('status', 'active')
              .maybeSingle();

      if (data == null) return null;
      return SubscriptionModel.fromJson(data);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<SubscriptionPlan>> getAvailablePlans() async {
    try {
      final List<dynamic> data = await _client
          .from('subscription_plans')
          .select()
          .eq('is_active', true);

      return data
          .map((e) => SubscriptionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Subscription> upgradeSubscription({
    required String subscriptionId,
    required String newPlanId,
  }) async {
    try {
      // 1. Fetch current subscription
      final subData =
          await _client
              .from('subscriptions')
              .select('*, plan:subscription_plans(*)')
              .eq('id', subscriptionId)
              .single();
      final currentSub = SubscriptionModel.fromJson(subData);

      // 2. Fetch new plan
      final planData =
          await _client
              .from('subscription_plans')
              .select()
              .eq('id', newPlanId)
              .single();
      final newPlan = SubscriptionPlanModel.fromJson(planData);

      // 3. Validation: reject downgrades
      if (newPlan.memberLimit < currentSub.plan.memberLimit) {
        throw ArgumentError(
          'Downgrades are not allowed. New plan has lower member limit.',
        );
      }

      // 4. Update the plan
      final updatedData =
          await _client
              .from('subscriptions')
              .update({'plan_id': newPlanId})
              .eq('id', subscriptionId)
              .select('*, plan:subscription_plans(*)')
              .single();

      return SubscriptionModel.fromJson(updatedData);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<PlanUsage> getPlanUsage({required String leaderId}) async {
    try {
      final data = await _client.rpc(
        'get_leader_plan_usage',
        params: {'p_leader_id': leaderId},
      );
      return PlanUsageModel.fromJson(data as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<bool> canInviteMember({required String leaderId}) async {
    try {
      final usage = await getPlanUsage(leaderId: leaderId);
      return usage.canInvite;
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
