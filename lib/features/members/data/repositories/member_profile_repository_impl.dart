import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/repositories/member_repositories.dart';
import '../models/member_profile_view_model.dart';

class MemberProfileRepositoryImpl extends BaseRepository
    implements MemberProfileRepository {
  final supabase.SupabaseClient _client;

  MemberProfileRepositoryImpl(this._client);

  @override
  Future<MemberProfileViewModel> getMemberProfile(String profileId) async {
    try {
      final response = await _client.rpc(
        'get_member_profile_view_model',
        params: {'p_profile_id': profileId},
      );
      return MemberProfileViewModel.fromJson(response as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
