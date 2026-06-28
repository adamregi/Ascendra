import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_directory_model.freezed.dart';
part 'member_directory_model.g.dart';

@freezed
abstract class MemberDirectoryModel with _$MemberDirectoryModel {
  const factory MemberDirectoryModel({
    @JsonKey(name: 'profile_id') required String profileId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'distributor_id') String? distributorId,
    required String status,
    required String rank,
    @JsonKey(name: 'leader_name') String? leaderName,
    @JsonKey(name: 'meeting_percent') required int meetingPercent,
    @JsonKey(name: 'task_percent') required int taskPercent,
    @JsonKey(name: 'risk_level') required String riskLevel,
    @JsonKey(name: 'is_promotion_ready') required bool isPromotionReady,
    @JsonKey(name: 'recognition_count') required int recognitionCount,
  }) = _MemberDirectoryModel;

  factory MemberDirectoryModel.fromJson(Map<String, dynamic> json) =>
      _$MemberDirectoryModelFromJson(json);
}
