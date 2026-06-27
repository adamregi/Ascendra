import 'package:freezed_annotation/freezed_annotation.dart';

part 'leadership_pipeline_model.freezed.dart';
part 'leadership_pipeline_model.g.dart';

@freezed
abstract class LeadershipPipelineModel with _$LeadershipPipelineModel {
  const factory LeadershipPipelineModel({
    @JsonKey(name: 'future_leaders') @Default([]) List<PipelineMember> futureLeaders,
    @JsonKey(name: 'emerging_leaders') @Default([]) List<PipelineMember> emergingLeaders,
    @JsonKey(name: 'developing') @Default([]) List<PipelineMember> developing,
    @JsonKey(name: 'needs_development') @Default([]) List<PipelineMember> needsDevelopment,
  }) = _LeadershipPipelineModel;

  factory LeadershipPipelineModel.fromJson(Map<String, dynamic> json) =>
      _$LeadershipPipelineModelFromJson(json);
}

@freezed
abstract class PipelineMember with _$PipelineMember {
  const factory PipelineMember({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'leadership_score') required double leadershipScore,
    @JsonKey(name: 'leadership_band') required String leadershipBand,
    @JsonKey(name: 'company_percentile') double? companyPercentile,
    @JsonKey(name: 'attendance_delta_30d') double? attendanceDelta30d,
    @JsonKey(name: 'task_delta_30d') double? taskDelta30d,
  }) = _PipelineMember;

  const PipelineMember._();

  String get fullName => '$firstName $lastName';

  factory PipelineMember.fromJson(Map<String, dynamic> json) =>
      _$PipelineMemberFromJson(json);
}
