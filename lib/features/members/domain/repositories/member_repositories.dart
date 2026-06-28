import '../../data/models/member_profile_view_model.dart';
import '../../data/models/member_directory_model.dart';

abstract class MemberProfileRepository {
  Future<MemberProfileViewModel> getMemberProfile(String profileId);
}

abstract class MemberRepository {
  Future<List<MemberDirectoryModel>> getMemberDirectory({
    String? searchQuery,
    String? status,
    String? leaderId,
    bool? promotionReady,
    bool? highRisk,
  });
}
