import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/repositories/member_repositories.dart';
import '../models/member_directory_model.dart';

class MemberRepositoryImpl extends BaseRepository implements MemberRepository {
  final supabase.SupabaseClient _client;

  MemberRepositoryImpl(this._client);

  @override
  Future<List<MemberDirectoryModel>> getMemberDirectory({
    String? searchQuery,
    String? status,
    String? leaderId,
    bool? promotionReady,
    bool? highRisk,
  }) async {
    try {
      final response = await _client.rpc(
        'get_member_directory',
        params: {
          'p_company_id':
              '00000000-0000-0000-0000-000000000000', // Typically fetched from auth context
          'p_leader_id': leaderId,
          'p_search_query': searchQuery,
          'p_status': status,
          'p_promotion_ready': promotionReady,
          'p_high_risk': highRisk,
        },
      );

      final list = response as List<dynamic>;
      return list
          .map(
            (json) =>
                MemberDirectoryModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
