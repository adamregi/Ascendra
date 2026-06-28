import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const Task._();
  const factory Task({
    required String id,
    @JsonKey(name: 'company_id') required String companyId,
    required String title,
    String? description,
    required String priority, // 'high', 'medium', 'low'
    required String
    status, // 'open', 'in_progress', 'completed', 'overdue', 'cancelled'
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'assigned_to') required List<String> assignedTo,
    @JsonKey(name: 'proof_required') @Default(true) bool proofRequired,
    @JsonKey(name: 'proof_type')
    @Default('text')
    String proofType, // 'text', 'image', 'pdf', 'url'
    @JsonKey(name: 'completion_rule') String? completionRule,
    @Default([]) List<String> attachments,
    @Default([]) List<String> tags,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
