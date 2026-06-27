import '../../domain/entities/compliance_rule.dart';
import '../../domain/entities/compliance_rule_type.dart';
import '../../domain/entities/compliance_severity.dart';

class ComplianceRuleModel extends ComplianceRule {
  const ComplianceRuleModel({
    required super.id,
    required super.companyId,
    required super.ruleType,
    required super.threshold,
    required super.severity,
    required super.enabled,
    super.description,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ComplianceRuleModel.fromJson(Map<String, dynamic> json) {
    return ComplianceRuleModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      ruleType: ComplianceRuleType.fromJson(json['rule_type'] as String),
      threshold: json['threshold'] as int,
      severity: ComplianceSeverity.fromJson(json['severity'] as String),
      enabled: json['enabled'] as bool,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'rule_type': ruleType.toJson(),
      'threshold': threshold,
      'severity': severity.toJson(),
      'enabled': enabled,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
