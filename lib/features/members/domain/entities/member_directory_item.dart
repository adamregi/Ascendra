import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_directory_item.freezed.dart';

@freezed
abstract class MemberDirectoryItem with _$MemberDirectoryItem {
  const factory MemberDirectoryItem({
    required String profileId,
    required String firstName,
    required String lastName,
    String? avatarUrl,
    required String distributorId,
    required String status,
    required String rank,
    String? parentId,
    String? leaderName,
    required double meetingPercent,
    required double taskPercent,
    required String riskLevel,
    required bool isPromotionReady,
    required int recognitionCount,
  }) = _MemberDirectoryItem;
}
