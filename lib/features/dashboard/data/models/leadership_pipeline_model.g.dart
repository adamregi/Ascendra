// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leadership_pipeline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeadershipPipelineModel _$LeadershipPipelineModelFromJson(
  Map<String, dynamic> json,
) => _LeadershipPipelineModel(
  futureLeaders:
      (json['future_leaders'] as List<dynamic>?)
          ?.map((e) => PipelineMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  emergingLeaders:
      (json['emerging_leaders'] as List<dynamic>?)
          ?.map((e) => PipelineMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  developing:
      (json['developing'] as List<dynamic>?)
          ?.map((e) => PipelineMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  needsDevelopment:
      (json['needs_development'] as List<dynamic>?)
          ?.map((e) => PipelineMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$LeadershipPipelineModelToJson(
  _LeadershipPipelineModel instance,
) => <String, dynamic>{
  'future_leaders': instance.futureLeaders,
  'emerging_leaders': instance.emergingLeaders,
  'developing': instance.developing,
  'needs_development': instance.needsDevelopment,
};

_PipelineMember _$PipelineMemberFromJson(Map<String, dynamic> json) =>
    _PipelineMember(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      leadershipScore: (json['leadership_score'] as num).toDouble(),
      leadershipBand: json['leadership_band'] as String,
      companyPercentile: (json['company_percentile'] as num?)?.toDouble(),
      attendanceDelta30d: (json['attendance_delta_30d'] as num?)?.toDouble(),
      taskDelta30d: (json['task_delta_30d'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PipelineMemberToJson(_PipelineMember instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'leadership_score': instance.leadershipScore,
      'leadership_band': instance.leadershipBand,
      'company_percentile': instance.companyPercentile,
      'attendance_delta_30d': instance.attendanceDelta30d,
      'task_delta_30d': instance.taskDelta30d,
    };
