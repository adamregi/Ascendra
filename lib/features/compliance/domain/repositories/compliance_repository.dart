import '../entities/compliance_rule.dart';
import '../entities/compliance_event.dart';
import '../entities/compliance_violation.dart';
import '../entities/compliance_rule_type.dart';
import '../entities/compliance_severity.dart';
import '../entities/compliance_snapshot.dart';

abstract class ComplianceRepository {
  Future<List<ComplianceRule>> getRules({required String companyId});

  Future<ComplianceRule> createRule({
    required String companyId,
    required ComplianceRuleType ruleType,
    required int threshold,
    required ComplianceSeverity severity,
    bool enabled = true,
    String? description,
  });

  Future<ComplianceRule> updateRule({
    required String ruleId,
    required int threshold,
    required bool enabled,
  });

  Future<List<ComplianceEvent>> getEvents({
    required String companyId,
    String? profileId,
  });

  Future<List<ComplianceViolation>> getViolations({
    required String companyId,
    String? profileId,
  });

  Future<void> evaluateCompliance({required String companyId});

  Future<void> acknowledgeViolation({
    required String violationId,
    required String leaderId,
  });

  Future<ComplianceSnapshot> createSnapshot({required String profileId});

  Future<void> warnMember({required String profileId});

  Future<void> suspendMember({required String profileId});

  Future<void> terminateMember({
    required String profileId,
    required String leaderId,
    required String reason,
  });
}
