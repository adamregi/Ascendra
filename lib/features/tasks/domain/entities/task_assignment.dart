import 'assignment_status.dart';

class TaskAssignment {
  final String id;
  final String taskId;
  final String memberId;
  final DateTime assignedAt;
  final DateTime? startedAt;
  final DateTime? submittedAt;
  final DateTime? reviewedAt;
  final AssignmentStatus status;
  final String? reviewComment;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskAssignment({
    required this.id,
    required this.taskId,
    required this.memberId,
    required this.assignedAt,
    this.startedAt,
    this.submittedAt,
    this.reviewedAt,
    required this.status,
    this.reviewComment,
    required this.createdAt,
    required this.updatedAt,
  });
}
