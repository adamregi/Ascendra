// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_timeline_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberTimelineEventModel _$MemberTimelineEventModelFromJson(
  Map<String, dynamic> json,
) => _MemberTimelineEventModel(
  type: json['type'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$MemberTimelineEventModelToJson(
  _MemberTimelineEventModel instance,
) => <String, dynamic>{
  'type': instance.type,
  'timestamp': instance.timestamp.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
};
