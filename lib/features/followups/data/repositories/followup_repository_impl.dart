import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/followup.dart';
import '../../domain/entities/followup_status.dart';
import '../../domain/entities/followup_reason_type.dart';
import '../../domain/repositories/followup_repository.dart';
import '../models/followup_model.dart';

class FollowUpRepositoryImpl extends BaseRepository implements FollowUpRepository {
  final supabase.SupabaseClient _client;

  FollowUpRepositoryImpl(this._client);

  @override
  Future<FollowUp> createFollowUp({
    required String companyId,
    required String leaderId,
    required String memberId,
    required FollowUpReasonType reasonType,
    required String reason,
    String? notes,
    DateTime? dueDate,
  }) async {
    try {
      final response = await _client.rpc('create_followup', params: {
        'p_company_id': companyId,
        'p_leader_id': leaderId,
        'p_member_id': memberId,
        'p_reason_type': reasonType.toJson(),
        'p_reason': reason,
        'p_notes': notes,
        'p_due_date': dueDate?.toIso8601String(),
      });
      return FollowUpModel.fromJson(response as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<FollowUp> updateFollowUp({
    required String followupId,
    required String leaderId,
    required FollowUpStatus status,
    String? notes,
  }) async {
    try {
      final response = await _client.rpc('update_followup', params: {
        'p_followup_id': followupId,
        'p_leader_id': leaderId,
        'p_status': status.toJson(),
        'p_notes': notes,
      });
      return FollowUpModel.fromJson(response as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<FollowUp> completeFollowUp({
    required String followupId,
    required String leaderId,
    String? notes,
  }) async {
    return updateFollowUp(
      followupId: followupId,
      leaderId: leaderId,
      status: FollowUpStatus.completed,
      notes: notes,
    );
  }

  @override
  Future<List<FollowUp>> getFollowUps({required String companyId}) async {
    try {
      final List<dynamic> response = await _client
          .from('followups')
          .select()
          .eq('company_id', companyId);
      return response.map((e) => FollowUpModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
