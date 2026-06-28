import '../../domain/entities/member_directory_item.dart';
import '../dto/rpc/v1/member_directory_rpc_dto.dart';

class MemberDirectoryMapper {
  MemberDirectoryItem mapDtoToEntity(MemberDirectoryItemRpcDto dto) {
    return MemberDirectoryItem(
      profileId: dto.profileId,
      firstName: dto.firstName,
      lastName: dto.lastName,
      avatarUrl: dto.avatarUrl,
      distributorId: dto.distributorId,
      status: dto.status,
      rank: dto.rank,
      parentId: dto.parentId,
      leaderName: dto.leaderName,
      meetingPercent: dto.meetingPercent,
      taskPercent: dto.taskPercent,
      riskLevel: dto.riskLevel,
      isPromotionReady: dto.isPromotionReady,
      recognitionCount: dto.recognitionCount,
    );
  }

  List<MemberDirectoryItem> mapDtoListToEntityList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) =>
              MemberDirectoryItemRpcDto.fromJson(json as Map<String, dynamic>),
        )
        .map(mapDtoToEntity)
        .toList();
  }
}
