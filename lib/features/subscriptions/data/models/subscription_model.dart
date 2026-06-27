import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_status.dart';
import 'subscription_plan_model.dart';

class SubscriptionModel extends Subscription {
  const SubscriptionModel({
    required super.id,
    required super.leaderId,
    required super.plan,
    required super.status,
    required super.startedAt,
    required super.expiresAt,
    super.cancelledAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      leaderId: json['leader_id'] as String,
      plan: SubscriptionPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
      status: SubscriptionStatus.fromString(json['status'] as String),
      startedAt: DateTime.parse(json['started_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      cancelledAt: json['cancelled_at'] != null ? DateTime.parse(json['cancelled_at'] as String) : null,
    );
  }
}
