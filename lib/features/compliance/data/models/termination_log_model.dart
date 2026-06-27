import '../../domain/entities/termination_log.dart';

class TerminationLogModel extends TerminationLog {
  const TerminationLogModel({
    required super.id,
    required super.profileId,
    required super.companyId,
    required super.terminatorId,
    required super.reason,
    super.parentReassignedTo,
    super.restructuredAt,
    required super.createdAt,
  });

  factory TerminationLogModel.fromJson(Map<String, dynamic> json) {
    return TerminationLogModel(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      companyId: json['company_id'] as String,
      terminatorId: json['terminator_id'] as String,
      reason: json['reason'] as String,
      parentReassignedTo: json['parent_reassigned_to'] as String?,
      restructuredAt: json['restructured_at'] != null ? DateTime.parse(json['restructured_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profileId,
      'company_id': companyId,
      'terminator_id': terminatorId,
      'reason': reason,
      'parent_reassigned_to': parentReassignedTo,
      'restructured_at': restructuredAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
