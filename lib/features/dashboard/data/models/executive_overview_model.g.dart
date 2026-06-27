// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'executive_overview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExecutiveOverviewModel _$ExecutiveOverviewModelFromJson(
  Map<String, dynamic> json,
) => _ExecutiveOverviewModel(
  health:
      json['health'] == null
          ? null
          : OverviewHealth.fromJson(json['health'] as Map<String, dynamic>),
  growth:
      json['growth'] == null
          ? null
          : OverviewGrowth.fromJson(json['growth'] as Map<String, dynamic>),
  risk:
      json['risk'] == null
          ? null
          : OverviewRisk.fromJson(json['risk'] as Map<String, dynamic>),
  pipeline:
      json['pipeline'] == null
          ? null
          : OverviewPipeline.fromJson(json['pipeline'] as Map<String, dynamic>),
  pendingActions:
      json['pending_actions'] == null
          ? null
          : OverviewActions.fromJson(
            json['pending_actions'] as Map<String, dynamic>,
          ),
  generatedAt:
      json['generated_at'] == null
          ? null
          : DateTime.parse(json['generated_at'] as String),
  fallbackHealthScore: (json['team_health_score'] as num?)?.toDouble(),
  fallbackTeamSize: (json['team_size'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$ExecutiveOverviewModelToJson(
  _ExecutiveOverviewModel instance,
) => <String, dynamic>{
  'health': instance.health,
  'growth': instance.growth,
  'risk': instance.risk,
  'pipeline': instance.pipeline,
  'pending_actions': instance.pendingActions,
  'generated_at': instance.generatedAt?.toIso8601String(),
  'team_health_score': instance.fallbackHealthScore,
  'team_size': instance.fallbackTeamSize,
  'message': instance.message,
};

_OverviewHealth _$OverviewHealthFromJson(Map<String, dynamic> json) =>
    _OverviewHealth(
      teamHealthScore: (json['team_health_score'] as num).toDouble(),
      teamSize: (json['team_size'] as num).toInt(),
      activeMembers: (json['active_members'] as num).toInt(),
      attendanceRate: (json['attendance_rate'] as num).toDouble(),
      completionRate: (json['completion_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$OverviewHealthToJson(_OverviewHealth instance) =>
    <String, dynamic>{
      'team_health_score': instance.teamHealthScore,
      'team_size': instance.teamSize,
      'active_members': instance.activeMembers,
      'attendance_rate': instance.attendanceRate,
      'completion_rate': instance.completionRate,
    };

_OverviewGrowth _$OverviewGrowthFromJson(Map<String, dynamic> json) =>
    _OverviewGrowth(
      teamGrowthScore: (json['team_growth_score'] as num).toDouble(),
      taskGrowthScore: (json['task_growth_score'] as num).toDouble(),
    );

Map<String, dynamic> _$OverviewGrowthToJson(_OverviewGrowth instance) =>
    <String, dynamic>{
      'team_growth_score': instance.teamGrowthScore,
      'task_growth_score': instance.taskGrowthScore,
    };

_OverviewRisk _$OverviewRiskFromJson(Map<String, dynamic> json) =>
    _OverviewRisk(
      low: (json['low'] as num).toInt(),
      medium: (json['medium'] as num).toInt(),
      high: (json['high'] as num).toInt(),
      critical: (json['critical'] as num).toInt(),
      riskPercentage: (json['risk_percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$OverviewRiskToJson(_OverviewRisk instance) =>
    <String, dynamic>{
      'low': instance.low,
      'medium': instance.medium,
      'high': instance.high,
      'critical': instance.critical,
      'risk_percentage': instance.riskPercentage,
    };

_OverviewPipeline _$OverviewPipelineFromJson(Map<String, dynamic> json) =>
    _OverviewPipeline(
      futureLeaders: (json['future_leaders'] as num).toInt(),
      emergingLeaders: (json['emerging_leaders'] as num).toInt(),
      developing: (json['developing'] as num).toInt(),
      needsDevelopment: (json['needs_development'] as num).toInt(),
      topPerformers: (json['top_performers'] as num).toInt(),
    );

Map<String, dynamic> _$OverviewPipelineToJson(_OverviewPipeline instance) =>
    <String, dynamic>{
      'future_leaders': instance.futureLeaders,
      'emerging_leaders': instance.emergingLeaders,
      'developing': instance.developing,
      'needs_development': instance.needsDevelopment,
      'top_performers': instance.topPerformers,
    };

_OverviewActions _$OverviewActionsFromJson(Map<String, dynamic> json) =>
    _OverviewActions(
      promotions: (json['promotions'] as num).toInt(),
      recognitions: (json['recognitions'] as num).toInt(),
      mentorships: (json['mentorships'] as num).toInt(),
      trainings: (json['trainings'] as num).toInt(),
      coaching: (json['coaching'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$OverviewActionsToJson(_OverviewActions instance) =>
    <String, dynamic>{
      'promotions': instance.promotions,
      'recognitions': instance.recognitions,
      'mentorships': instance.mentorships,
      'trainings': instance.trainings,
      'coaching': instance.coaching,
      'total': instance.total,
    };
