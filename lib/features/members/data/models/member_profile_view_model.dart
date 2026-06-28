import 'package:freezed_annotation/freezed_annotation.dart';
import 'member_timeline_event_model.dart';
import 'member_recognition_model.dart';
import 'member_analytics_model.dart';

part 'member_profile_view_model.freezed.dart';
part 'member_profile_view_model.g.dart';

@freezed
abstract class MemberProfileViewModel with _$MemberProfileViewModel {
  const factory MemberProfileViewModel({
    required int version,
    @JsonKey(name: 'generated_at') required DateTime generatedAt,
    required MemberHeroModel hero,
    required MemberOverviewModel overview,
    required MemberComplianceModel compliance,
    required List<MemberTimelineEventModel> timeline,
    required List<MemberRecognitionModel> recognition,
    required MemberAnalyticsModel analytics,
  }) = _MemberProfileViewModel;

  factory MemberProfileViewModel.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileViewModelFromJson(json);
}

@freezed
abstract class MemberHeroModel with _$MemberHeroModel {
  const factory MemberHeroModel({
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'distributor_id') required String distributorId,
    @JsonKey(name: 'leader_name') String? leaderName,
    required String rank,
    required String status,
    @JsonKey(name: 'joined_date') required DateTime joinedDate,
    @JsonKey(name: 'current_streak') required int currentStreak,
  }) = _MemberHeroModel;

  factory MemberHeroModel.fromJson(Map<String, dynamic> json) =>
      _$MemberHeroModelFromJson(json);
}

@freezed
abstract class MemberOverviewModel with _$MemberOverviewModel {
  const factory MemberOverviewModel({
    @JsonKey(name: 'leadership_score') required int leadershipScore,
    @JsonKey(name: 'recognition_count') required int recognitionCount,
    @JsonKey(name: 'compliance_score') required int complianceScore,
    @JsonKey(name: 'meeting_percent') required int meetingPercent,
    @JsonKey(name: 'task_percent') required int taskPercent,
    @JsonKey(name: 'risk_level') required String riskLevel,
  }) = _MemberOverviewModel;

  factory MemberOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$MemberOverviewModelFromJson(json);
}

@freezed
abstract class MemberComplianceModel with _$MemberComplianceModel {
  const factory MemberComplianceModel({
    required int score,
    required List<String> reasons,
    @JsonKey(name: 'next_improvement') required String nextImprovement,
  }) = _MemberComplianceModel;

  factory MemberComplianceModel.fromJson(Map<String, dynamic> json) =>
      _$MemberComplianceModelFromJson(json);
}
