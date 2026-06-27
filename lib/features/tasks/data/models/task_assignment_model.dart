import '../../domain/entities/task_assignment.dart';
import '../../domain/entities/assignment_status.dart';

class TaskAssignmentModel extends TaskAssignment {
  const TaskAssignmentModel({
    required super.id,
    required super.taskId,
    required super.memberId,
    required super.assignedAt,
    super.startedAt,
    super.submittedAt,
    super.reviewedAt,
    required super.status,
    super.reviewComment,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TaskAssignmentModel.fromJson(Map<String, dynamic> json) {
    return TaskAssignmentModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      memberId: json['member_id'] as String,
      assignedAt: DateTime.parse(json['assigned_at'] as String),
      startedAt: json['started_at'] != null ? DateTime.parse(json['started_at'] as String) : null,
      submittedAt: json['submitted_at'] != null ? DateTime.parse(json['submitted_at'] as String) : null,
      reviewedAt: json['reviewed_at'] != null ? DateTime.parse(json['reviewed_at'] as String) : null,
      status: AssignmentStatus.fromString(json['status'] as String),
      reviewComment: json['review_comment'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'member_id': memberId,
      'assigned_at': assignedAt.toIso8601String(),
      'started_at': startedAt?.toIso8601String(),
      'submitted_at': submittedAt?.toIso8601String(),
      'reviewed_at': reviewedAt?.toIso8601String(),
      'status': status.toJson(),
      'review_comment': reviewComment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
