import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/compliance_rule.dart';
import '../../domain/entities/compliance_event.dart';
import '../../domain/entities/compliance_violation.dart';
import '../../domain/entities/compliance_rule_type.dart';
import '../../domain/entities/compliance_severity.dart';
import '../../domain/repositories/compliance_repository.dart';
import '../models/compliance_rule_model.dart';
import '../models/compliance_event_model.dart';
import '../models/compliance_violation_model.dart';
import '../models/compliance_snapshot_model.dart';
import '../../domain/entities/compliance_snapshot.dart';

class ComplianceRepositoryImpl extends BaseRepository
    implements ComplianceRepository {
  final supabase.SupabaseClient _client;

  ComplianceRepositoryImpl(this._client);

  @override
  Future<List<ComplianceRule>> getRules({required String companyId}) async {
    try {
      final List<dynamic> response = await _client
          .from('compliance_rules')
          .select()
          .eq('company_id', companyId);
      return response
          .map((e) => ComplianceRuleModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<ComplianceRule> createRule({
    required String companyId,
    required ComplianceRuleType ruleType,
    required int threshold,
    required ComplianceSeverity severity,
    bool enabled = true,
    String? description,
  }) async {
    try {
      final response =
          await _client
              .from('compliance_rules')
              .insert({
                'company_id': companyId,
                'rule_type': ruleType.toJson(),
                'threshold': threshold,
                'severity': severity.toJson(),
                'enabled': enabled,
                'description': description,
              })
              .select()
              .single();
      return ComplianceRuleModel.fromJson(response);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<ComplianceRule> updateRule({
    required String ruleId,
    required int threshold,
    required bool enabled,
  }) async {
    try {
      final response =
          await _client
              .from('compliance_rules')
              .update({'threshold': threshold, 'enabled': enabled})
              .eq('id', ruleId)
              .select()
              .single();
      return ComplianceRuleModel.fromJson(response);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<ComplianceEvent>> getEvents({
    required String companyId,
    String? profileId,
  }) async {
    try {
      var query = _client
          .from('compliance_events')
          .select()
          .eq('company_id', companyId);
      if (profileId != null) {
        query = query.eq('profile_id', profileId);
      }
      final List<dynamic> response = await query;
      return response
          .map((e) => ComplianceEventModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<ComplianceViolation>> getViolations({
    required String companyId,
    String? profileId,
  }) async {
    try {
      var query = _client
          .from('compliance_violations')
          .select()
          .eq('company_id', companyId);
      if (profileId != null) {
        query = query.eq('profile_id', profileId);
      }
      final List<dynamic> response = await query;
      return response
          .map(
            (e) => ComplianceViolationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> evaluateCompliance({required String companyId}) async {
    try {
      await _client.rpc(
        'evaluate_compliance',
        params: {'p_company_id': companyId},
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> acknowledgeViolation({
    required String violationId,
    required String leaderId,
  }) async {
    try {
      await _client.rpc(
        'acknowledge_violation',
        params: {'p_violation_id': violationId, 'p_leader_id': leaderId},
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<ComplianceSnapshot> createSnapshot({required String profileId}) async {
    try {
      final response = await _client.rpc(
        'create_compliance_snapshot',
        params: {'p_profile_id': profileId},
      );
      return ComplianceSnapshotModel.fromJson(response as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> warnMember({required String profileId}) async {
    try {
      await _client.rpc('warn_member', params: {'p_profile_id': profileId});
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> suspendMember({required String profileId}) async {
    try {
      await _client.rpc('suspend_member', params: {'p_profile_id': profileId});
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> terminateMember({
    required String profileId,
    required String leaderId,
    required String reason,
  }) async {
    try {
      await _client.rpc(
        'terminate_member',
        params: {
          'p_profile_id': profileId,
          'p_leader_id': leaderId,
          'p_reason': reason,
        },
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
