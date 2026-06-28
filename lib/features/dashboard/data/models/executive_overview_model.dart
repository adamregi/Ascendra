import 'package:freezed_annotation/freezed_annotation.dart';

part 'executive_overview_model.freezed.dart';
part 'executive_overview_model.g.dart';

@freezed
abstract class ExecutiveOverviewModel with _$ExecutiveOverviewModel {
  const factory ExecutiveOverviewModel({
    @JsonKey(name: 'health') OverviewHealth? health,
    @JsonKey(name: 'growth') OverviewGrowth? growth,
    @JsonKey(name: 'risk') OverviewRisk? risk,
    @JsonKey(name: 'pipeline') OverviewPipeline? pipeline,
    @JsonKey(name: 'pending_actions') OverviewActions? pendingActions,
    @JsonKey(name: 'generated_at') DateTime? generatedAt,

    // Fallback fields when data is empty
    @JsonKey(name: 'team_health_score') double? fallbackHealthScore,
    @JsonKey(name: 'team_size') int? fallbackTeamSize,
    @JsonKey(name: 'message') String? message,
  }) = _ExecutiveOverviewModel;

  factory ExecutiveOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$ExecutiveOverviewModelFromJson(json);
}

@freezed
abstract class OverviewHealth with _$OverviewHealth {
  const factory OverviewHealth({
    @JsonKey(name: 'team_health_score') required double teamHealthScore,
    @JsonKey(name: 'team_size') required int teamSize,
    @JsonKey(name: 'active_members') required int activeMembers,
    @JsonKey(name: 'attendance_rate') required double attendanceRate,
    @JsonKey(name: 'completion_rate') required double completionRate,
  }) = _OverviewHealth;

  factory OverviewHealth.fromJson(Map<String, dynamic> json) =>
      _$OverviewHealthFromJson(json);
}

@freezed
abstract class OverviewGrowth with _$OverviewGrowth {
  const factory OverviewGrowth({
    @JsonKey(name: 'team_growth_score') required double teamGrowthScore,
    @JsonKey(name: 'task_growth_score') required double taskGrowthScore,
  }) = _OverviewGrowth;

  factory OverviewGrowth.fromJson(Map<String, dynamic> json) =>
      _$OverviewGrowthFromJson(json);
}

@freezed
abstract class OverviewRisk with _$OverviewRisk {
  const factory OverviewRisk({
    required int low,
    required int medium,
    required int high,
    required int critical,
    @JsonKey(name: 'risk_percentage') required double riskPercentage,
  }) = _OverviewRisk;

  factory OverviewRisk.fromJson(Map<String, dynamic> json) =>
      _$OverviewRiskFromJson(json);
}

@freezed
abstract class OverviewPipeline with _$OverviewPipeline {
  const factory OverviewPipeline({
    @JsonKey(name: 'future_leaders') required int futureLeaders,
    @JsonKey(name: 'emerging_leaders') required int emergingLeaders,
    required int developing,
    @JsonKey(name: 'needs_development') required int needsDevelopment,
    @JsonKey(name: 'top_performers') required int topPerformers,
  }) = _OverviewPipeline;

  factory OverviewPipeline.fromJson(Map<String, dynamic> json) =>
      _$OverviewPipelineFromJson(json);
}

@freezed
abstract class OverviewActions with _$OverviewActions {
  const factory OverviewActions({
    required int promotions,
    required int recognitions,
    required int mentorships,
    required int trainings,
    required int coaching,
    required int total,
  }) = _OverviewActions;

  factory OverviewActions.fromJson(Map<String, dynamic> json) =>
      _$OverviewActionsFromJson(json);
}
