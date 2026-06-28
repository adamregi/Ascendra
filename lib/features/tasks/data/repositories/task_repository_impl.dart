import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_assignment.dart';
import '../../domain/entities/task_proof.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_assignment_model.dart';

class TaskRepositoryImpl extends BaseRepository implements TaskRepository {
  final supabase.SupabaseClient _client;

  TaskRepositoryImpl(this._client);

  @override
  Future<Task> createTask({
    required String companyId,
    required String leaderId,
    required String title,
    String? description,
    TaskPriority priority = TaskPriority.normal,
    DateTime? dueDate,
  }) async {
    try {
      final response = await _client.rpc(
        'create_task_atomic',
        params: {
          'p_company_id': companyId,
          'p_leader_id': leaderId,
          'p_title': title,
          'p_description': description,
          'p_priority': priority.toJson(),
          'p_due_date': dueDate?.toIso8601String(),
        },
      );
      return Task.fromJson(response as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> assignMembers({
    required String taskId,
    required List<String> memberIds,
  }) async {
    try {
      await _client.rpc(
        'assign_task_members',
        params: {'p_task_id': taskId, 'p_member_ids': memberIds},
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> startAssignment({required String assignmentId}) async {
    try {
      await _client.rpc(
        'start_task_assignment',
        params: {'p_assignment_id': assignmentId},
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<TaskProof> submitProof({
    required String assignmentId,
    required String proofType,
    String? comment,
    String? fileUrl,
  }) async {
    try {
      final response = await _client.rpc(
        'submit_task_proof',
        params: {
          'p_assignment_id': assignmentId,
          'p_proof_type': proofType,
          'p_comment': comment,
          'p_file_url': fileUrl,
        },
      );
      return TaskProof.fromJson(response as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> reviewAssignment({
    required String assignmentId,
    required String leaderId,
    required bool approved,
    String? comment,
  }) async {
    try {
      await _client.rpc(
        'review_task_assignment',
        params: {
          'p_assignment_id': assignmentId,
          'p_leader_id': leaderId,
          'p_approved': approved,
          'p_comment': comment,
        },
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<Task>> getTasks({required String companyId}) async {
    try {
      final List<dynamic> response = await _client
          .from('tasks')
          .select()
          .eq('company_id', companyId);
      return response
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<TaskAssignment>> getAssignments({required String taskId}) async {
    try {
      final taskRes =
          await _client
              .from('tasks')
              .select('company_id')
              .eq('id', taskId)
              .single();
      final companyId = taskRes['company_id'] as String;
      await _client.rpc(
        'sync_overdue_assignments',
        params: {'p_company_id': companyId},
      );

      final List<dynamic> response = await _client
          .from('task_assignments')
          .select()
          .eq('task_id', taskId);
      return response
          .map((e) => TaskAssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<TaskAssignment>> getMemberAssignments({
    required String memberId,
  }) async {
    try {
      final memberRes =
          await _client
              .from('profiles')
              .select('company_id')
              .eq('id', memberId)
              .single();
      final companyId = memberRes['company_id'] as String;
      await _client.rpc(
        'sync_overdue_assignments',
        params: {'p_company_id': companyId},
      );

      final List<dynamic> response = await _client
          .from('task_assignments')
          .select()
          .eq('member_id', memberId);
      return response
          .map((e) => TaskAssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
