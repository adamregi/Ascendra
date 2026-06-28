import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_profile_rpc_dto.freezed.dart';
part 'member_profile_rpc_dto.g.dart';

@freezed
abstract class MemberProfileRpcDto with _$MemberProfileRpcDto {
  const factory MemberProfileRpcDto({
    required int version,
    @JsonKey(name: 'generated_at') required DateTime generatedAt,
    required MemberProfileHeroDto hero,
    required MemberProfileOverviewDto overview,
    required MemberProfileComplianceDto compliance,
    required List<MemberProfileTimelineDto> timeline,
    required List<MemberProfileRecognitionDto> recognition,
    required MemberProfileAnalyticsDto analytics,
  }) = _MemberProfileRpcDto;

  factory MemberProfileRpcDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileRpcDtoFromJson(json);
}

@freezed
abstract class MemberProfileHeroDto with _$MemberProfileHeroDto {
  const factory MemberProfileHeroDto({
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'distributor_id') required String distributorId,
    @JsonKey(name: 'leader_name') String? leaderName,
    required String rank,
    required String status,
    @JsonKey(name: 'joined_date') required DateTime joinedDate,
    @JsonKey(name: 'current_streak') required int currentStreak,
  }) = _MemberProfileHeroDto;

  factory MemberProfileHeroDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileHeroDtoFromJson(json);
}

@freezed
abstract class MemberProfileOverviewDto with _$MemberProfileOverviewDto {
  const factory MemberProfileOverviewDto({
    @JsonKey(name: 'leadership_score') required int leadershipScore,
    @JsonKey(name: 'recognition_count') required int recognitionCount,
    @JsonKey(name: 'compliance_score') required int complianceScore,
    @JsonKey(name: 'meeting_percent') required double meetingPercent,
    @JsonKey(name: 'task_percent') required double taskPercent,
    @JsonKey(name: 'risk_level') required String riskLevel,
  }) = _MemberProfileOverviewDto;

  factory MemberProfileOverviewDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileOverviewDtoFromJson(json);
}

@freezed
abstract class MemberProfileComplianceDto with _$MemberProfileComplianceDto {
  const factory MemberProfileComplianceDto({
    required int score,
    required List<String> reasons,
    @JsonKey(name: 'next_improvement') required String nextImprovement,
  }) = _MemberProfileComplianceDto;

  factory MemberProfileComplianceDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileComplianceDtoFromJson(json);
}

@freezed
abstract class MemberProfileTimelineDto with _$MemberProfileTimelineDto {
  const factory MemberProfileTimelineDto({
    required String type,
    required DateTime timestamp,
    required String title,
    required String description,
  }) = _MemberProfileTimelineDto;

  factory MemberProfileTimelineDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileTimelineDtoFromJson(json);
}

@freezed
abstract class MemberProfileRecognitionDto with _$MemberProfileRecognitionDto {
  const factory MemberProfileRecognitionDto({
    required String name,
    required String description,
    @JsonKey(name: 'earned_date') required DateTime earnedDate,
    required String category,
    required String icon,
    required int level,
    required int points,
  }) = _MemberProfileRecognitionDto;

  factory MemberProfileRecognitionDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileRecognitionDtoFromJson(json);
}

@freezed
abstract class MemberProfileAnalyticsDto with _$MemberProfileAnalyticsDto {
  const factory MemberProfileAnalyticsDto({
    @JsonKey(name: 'leadership_trend') required List<int> leadershipTrend,
    @JsonKey(name: 'attendance_trend') required List<int> attendanceTrend,
    @JsonKey(name: 'task_trend') required List<int> taskTrend,
  }) = _MemberProfileAnalyticsDto;

  factory MemberProfileAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileAnalyticsDtoFromJson(json);
}
