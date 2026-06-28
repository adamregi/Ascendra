import '../../domain/entities/compliance_snapshot.dart';

class ComplianceSnapshotModel extends ComplianceSnapshot {
  const ComplianceSnapshotModel({
    required super.id,
    required super.profileId,
    required super.companyId,
    required super.attendanceScore,
    required super.taskScore,
    required super.followupScore,
    required super.complianceScore,
    required super.memberHealthScore,
    super.teamHealthScore,
    required super.snapshotDate,
    required super.createdAt,
  });

  factory ComplianceSnapshotModel.fromJson(Map<String, dynamic> json) {
    return ComplianceSnapshotModel(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      companyId: json['company_id'] as String,
      attendanceScore: (json['attendance_score'] as num).toDouble(),
      taskScore: (json['task_score'] as num).toDouble(),
      followupScore: (json['followup_score'] as num).toDouble(),
      complianceScore: (json['compliance_score'] as num).toDouble(),
      memberHealthScore: (json['member_health_score'] as num).toDouble(),
      teamHealthScore:
          json['team_health_score'] != null
              ? (json['team_health_score'] as num).toDouble()
              : null,
      snapshotDate: DateTime.parse(json['snapshot_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profileId,
      'company_id': companyId,
      'attendance_score': attendanceScore,
      'task_score': taskScore,
      'followup_score': followupScore,
      'compliance_score': complianceScore,
      'member_health_score': memberHealthScore,
      'team_health_score': teamHealthScore,
      'snapshot_date': snapshotDate.toIso8601String().split('T').first,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
