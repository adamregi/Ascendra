import 'compliance_rule_type.dart';
import 'compliance_severity.dart';

class ComplianceRule {
  final String id;
  final String companyId;
  final ComplianceRuleType ruleType;
  final int threshold;
  final ComplianceSeverity severity;
  final bool enabled;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ComplianceRule({
    required this.id,
    required this.companyId,
    required this.ruleType,
    required this.threshold,
    required this.severity,
    required this.enabled,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
