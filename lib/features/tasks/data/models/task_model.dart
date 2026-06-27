import '../../domain/entities/task.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/entities/task_priority.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.companyId,
    required super.leaderId,
    required super.title,
    super.description,
    required super.status,
    required super.priority,
    super.dueDate,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      leaderId: json['leader_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: TaskStatus.fromString(json['status'] as String),
      priority: TaskPriority.fromString(json['priority'] as String),
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'leader_id': leaderId,
      'title': title,
      'description': description,
      'status': status.toJson(),
      'priority': priority.toJson(),
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
