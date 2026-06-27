import '../../domain/entities/task.dart';
import '../../domain/entities/task_assignment.dart';
import '../../domain/entities/task_proof.dart';
import '../../domain/entities/task_priority.dart';

/// Abstract contract for task management operations.
abstract class TaskRepository {
  /// Create a new task definition.
  Future<Task> createTask({
    required String companyId,
    required String leaderId,
    required String title,
    String? description,
    TaskPriority priority = TaskPriority.normal,
    DateTime? dueDate,
  });

  /// Assign members to a task definition.
  Future<void> assignMembers({
    required String taskId,
    required List<String> memberIds,
  });

  /// Mark task assignment as in-progress.
  Future<void> startAssignment({
    required String assignmentId,
  });

  /// Submit task completion proof.
  Future<TaskProof> submitProof({
    required String assignmentId,
    required String proofType,
    String? comment,
    String? fileUrl,
  });

  /// Review a member's task submission (approve or reject with comment).
  Future<void> reviewAssignment({
    required String assignmentId,
    required String leaderId,
    required bool approved,
    String? comment,
  });

  /// Retrieve all tasks for a company.
  Future<List<Task>> getTasks({required String companyId});

  /// Retrieve assignments for a specific task.
  Future<List<TaskAssignment>> getAssignments({required String taskId});

  /// Retrieve assignments for a specific member.
  Future<List<TaskAssignment>> getMemberAssignments({required String memberId});
}
