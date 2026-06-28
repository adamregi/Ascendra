// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_analytics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberAnalyticsModel _$MemberAnalyticsModelFromJson(
  Map<String, dynamic> json,
) => _MemberAnalyticsModel(
  leadershipTrend:
      (json['leadership_trend'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  attendanceTrend:
      (json['attendance_trend'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  taskTrend:
      (json['task_trend'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$MemberAnalyticsModelToJson(
  _MemberAnalyticsModel instance,
) => <String, dynamic>{
  'leadership_trend': instance.leadershipTrend,
  'attendance_trend': instance.attendanceTrend,
  'task_trend': instance.taskTrend,
};
