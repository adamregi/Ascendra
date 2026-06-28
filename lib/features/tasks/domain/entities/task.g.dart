// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  companyId: json['company_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  priority: json['priority'] as String,
  status: json['status'] as String,
  dueDate:
      json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
  createdBy: json['created_by'] as String,
  assignedTo:
      (json['assigned_to'] as List<dynamic>).map((e) => e as String).toList(),
  proofRequired: json['proof_required'] as bool? ?? true,
  proofType: json['proof_type'] as String? ?? 'text',
  completionRule: json['completion_rule'] as String?,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'company_id': instance.companyId,
  'title': instance.title,
  'description': instance.description,
  'priority': instance.priority,
  'status': instance.status,
  'due_date': instance.dueDate?.toIso8601String(),
  'created_by': instance.createdBy,
  'assigned_to': instance.assignedTo,
  'proof_required': instance.proofRequired,
  'proof_type': instance.proofType,
  'completion_rule': instance.completionRule,
  'attachments': instance.attachments,
  'tags': instance.tags,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
