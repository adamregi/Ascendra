import '../../../../core/failures/failure.dart';
import '../../../../core/types/result.dart';
import '../../domain/entities/member_directory_item.dart';
import '../../domain/entities/member_directory_query.dart';
import '../../domain/entities/member_profile.dart';
import '../../domain/repositories/member_read_repository.dart';
import '../datasources/member_remote_data_source.dart';
import '../mappers/member_directory_mapper.dart';
import '../mappers/member_profile_mapper.dart';

class MemberReadRepositoryImpl implements MemberReadRepository {
  final MemberRemoteDataSource _remoteDataSource;
  final MemberProfileMapper _profileMapper;
  final MemberDirectoryMapper _directoryMapper;

  MemberReadRepositoryImpl({
    required MemberRemoteDataSource remoteDataSource,
    required MemberProfileMapper profileMapper,
    required MemberDirectoryMapper directoryMapper,
  }) : _remoteDataSource = remoteDataSource,
       _profileMapper = profileMapper,
       _directoryMapper = directoryMapper;

  @override
  Future<Result<MemberProfile>> fetchMemberProfile(String profileId) async {
    try {
      final dto = await _remoteDataSource.fetchMemberProfile(profileId);
      final entity = _profileMapper.mapDtoToEntity(dto);
      return Success(entity);
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<MemberDirectoryItem>>> fetchMemberDirectory(
    String companyId,
    String leaderId,
    MemberDirectoryQueryParams params,
  ) async {
    try {
      final dtos = await _remoteDataSource.fetchMemberDirectory(
        companyId,
        leaderId,
        params,
      );
      final entities = dtos.map(_directoryMapper.mapDtoToEntity).toList();
      return Success(entities);
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }
}
