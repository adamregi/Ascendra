import 'package:supabase_flutter/supabase_flutter.dart';

import '../dto/rpc/v1/member_directory_rpc_dto.dart';
import '../dto/rpc/v1/member_profile_rpc_dto.dart';
import '../../domain/entities/member_directory_query.dart';

abstract class MemberRemoteDataSource {
  Future<MemberProfileRpcDto> fetchMemberProfile(String profileId);
  Future<List<MemberDirectoryItemRpcDto>> fetchMemberDirectory(
    String companyId,
    String leaderId,
    MemberDirectoryQueryParams params,
  );
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final SupabaseClient _client;

  MemberRemoteDataSourceImpl(this._client);

  @override
  Future<MemberProfileRpcDto> fetchMemberProfile(String profileId) async {
    final response = await _client.rpc(
      'get_member_profile_view_model',
      params: {'p_profile_id': profileId},
    );

    if (response == null) {
      throw Exception('Profile not found');
    }

    return MemberProfileRpcDto.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<List<MemberDirectoryItemRpcDto>> fetchMemberDirectory(
    String companyId,
    String leaderId,
    MemberDirectoryQueryParams params,
  ) async {
    final Map<String, dynamic> rpcParams = {
      'p_company_id': companyId,
      'p_leader_id': leaderId,
      if (params.filter.searchQuery != null)
        'p_search_query': params.filter.searchQuery,
      if (params.filter.status != null) 'p_status': params.filter.status,
      if (params.filter.leaderId != null) 'p_leader': params.filter.leaderId,
      if (params.filter.promotionReady != null)
        'p_promotion_ready': params.filter.promotionReady,
      if (params.filter.highRisk != null) 'p_high_risk': params.filter.highRisk,
    };

    final response = await _client.rpc(
      'get_member_directory',
      params: rpcParams,
    );

    if (response == null) {
      return [];
    }

    final list = response as List<dynamic>;
    return list
        .map(
          (json) =>
              MemberDirectoryItemRpcDto.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
