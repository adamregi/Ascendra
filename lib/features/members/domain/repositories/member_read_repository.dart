import '../../../../core/types/result.dart';
import '../entities/member_directory_item.dart';
import '../entities/member_directory_query.dart';
import '../entities/member_profile.dart';

abstract class MemberReadRepository {
  Future<Result<MemberProfile>> fetchMemberProfile(String profileId);
  Future<Result<List<MemberDirectoryItem>>> fetchMemberDirectory(
    String companyId,
    String leaderId,
    MemberDirectoryQueryParams params,
  );
}
