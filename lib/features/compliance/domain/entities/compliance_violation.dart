import 'compliance_severity.dart';
import 'compliance_violation_status.dart';

class ComplianceViolation {
  final String id;
  final String profileId;
  final String companyId;
  final String ruleId;
  final ComplianceSeverity severity;
  final ComplianceViolationStatus status;
  final String? details;
  final DateTime createdAt;
  final DateTime? resolvedAt;

  const ComplianceViolation({
    required this.id,
    required this.profileId,
    required this.companyId,
    required this.ruleId,
    required this.severity,
    required this.status,
    this.details,
    required this.createdAt,
    this.resolvedAt,
  });
}
