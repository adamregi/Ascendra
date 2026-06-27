import '../../domain/entities/subscription_plan.dart';

class SubscriptionPlanModel extends SubscriptionPlan {
  const SubscriptionPlanModel({
    required super.id,
    required super.name,
    required super.memberLimit,
    required super.aiEnabled,
    required super.analyticsEnabled,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] as String,
      name: json['name'] as String,
      memberLimit: json['member_limit'] as int,
      aiEnabled: json['ai_enabled'] as bool,
      analyticsEnabled: json['analytics_enabled'] as bool,
    );
  }
}
