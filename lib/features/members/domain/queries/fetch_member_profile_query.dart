import '../../../../core/types/result.dart';
import '../entities/member_profile.dart';
import '../repositories/member_read_repository.dart';

class FetchMemberProfileQuery {
  final MemberReadRepository _repository;

  FetchMemberProfileQuery(this._repository);

  Future<Result<MemberProfile>> call(String profileId) {
    return _repository.fetchMemberProfile(profileId);
  }
}
