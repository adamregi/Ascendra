import '../../domain/entities/plan_usage.dart';

class PlanUsageModel extends PlanUsage {
  const PlanUsageModel({
    required super.limit,
    required super.activeMembers,
    required super.invitedMembers,
  });

  factory PlanUsageModel.fromJson(Map<String, dynamic> json) {
    return PlanUsageModel(
      limit: json['limit'] as int,
      activeMembers: json['active_members'] as int,
      invitedMembers: json['invited_members'] as int,
    );
  }
}
