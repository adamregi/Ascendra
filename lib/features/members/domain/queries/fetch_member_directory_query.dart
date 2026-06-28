import '../../../../core/types/result.dart';
import '../entities/member_directory_item.dart';
import '../entities/member_directory_query.dart';
import '../repositories/member_read_repository.dart';

class FetchMemberDirectoryQuery {
  final MemberReadRepository _repository;

  FetchMemberDirectoryQuery(this._repository);

  Future<Result<List<MemberDirectoryItem>>> call(
    String companyId,
    String leaderId,
    MemberDirectoryQueryParams params,
  ) {
    return _repository.fetchMemberDirectory(companyId, leaderId, params);
  }
}
