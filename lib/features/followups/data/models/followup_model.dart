import '../../domain/entities/followup.dart';
import '../../domain/entities/followup_status.dart';
import '../../domain/entities/followup_reason_type.dart';

class FollowUpModel extends FollowUp {
  const FollowUpModel({
    required super.id,
    required super.companyId,
    required super.leaderId,
    required super.memberId,
    required super.reasonType,
    required super.reason,
    super.notes,
    super.dueDate,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory FollowUpModel.fromJson(Map<String, dynamic> json) {
    return FollowUpModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      leaderId: json['leader_id'] as String,
      memberId: json['member_id'] as String,
      reasonType: FollowUpReasonType.fromString(json['reason_type'] as String),
      reason: json['reason'] as String,
      notes: json['notes'] as String?,
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date'] as String) : null,
      status: FollowUpStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'leader_id': leaderId,
      'member_id': memberId,
      'reason_type': reasonType.toJson(),
      'reason': reason,
      'notes': notes,
      'due_date': dueDate?.toIso8601String(),
      'status': status.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
