import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_directory_rpc_dto.freezed.dart';
part 'member_directory_rpc_dto.g.dart';

@freezed
abstract class MemberDirectoryItemRpcDto with _$MemberDirectoryItemRpcDto {
  const factory MemberDirectoryItemRpcDto({
    @JsonKey(name: 'profile_id') required String profileId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'distributor_id') required String distributorId,
    required String status,
    required String rank,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'leader_name') String? leaderName,
    @JsonKey(name: 'meeting_percent') required double meetingPercent,
    @JsonKey(name: 'task_percent') required double taskPercent,
    @JsonKey(name: 'risk_level') required String riskLevel,
    @JsonKey(name: 'is_promotion_ready') required bool isPromotionReady,
    @JsonKey(name: 'recognition_count') required int recognitionCount,
  }) = _MemberDirectoryItemRpcDto;

  factory MemberDirectoryItemRpcDto.fromJson(Map<String, dynamic> json) =>
      _$MemberDirectoryItemRpcDtoFromJson(json);
}
