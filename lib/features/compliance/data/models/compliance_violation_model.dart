import '../../domain/entities/compliance_violation.dart';
import '../../domain/entities/compliance_severity.dart';
import '../../domain/entities/compliance_violation_status.dart';

class ComplianceViolationModel extends ComplianceViolation {
  const ComplianceViolationModel({
    required super.id,
    required super.profileId,
    required super.companyId,
    required super.ruleId,
    required super.severity,
    required super.status,
    super.details,
    required super.createdAt,
    super.resolvedAt,
  });

  factory ComplianceViolationModel.fromJson(Map<String, dynamic> json) {
    return ComplianceViolationModel(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      companyId: json['company_id'] as String,
      ruleId: json['rule_id'] as String,
      severity: ComplianceSeverity.fromJson(json['severity'] as String),
      status: ComplianceViolationStatus.fromJson(json['status'] as String),
      details: json['details'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      resolvedAt: json['resolved_at'] != null
          ? DateTime.parse(json['resolved_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profileId,
      'company_id': companyId,
      'rule_id': ruleId,
      'severity': severity.toJson(),
      'status': status.toJson(),
      'details': details,
      'created_at': createdAt.toIso8601String(),
      'resolved_at': resolvedAt?.toIso8601String(),
    };
  }
}
