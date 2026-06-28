import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/failures/failure.dart';
import '../../../shared/models/member_profile.dart'; // We'll create this

part 'user_repository.g.dart';

class UserRepository {
  final SupabaseClient _supabase;

  UserRepository(this._supabase);

  Future<MemberProfile> getProfile(String authUserId) async {
    try {
      final response =
          await _supabase
              .from('profiles')
              .select()
              .eq('auth_user_id', authUserId)
              .single();

      return MemberProfile.fromJson(response);
    } catch (e) {
      throw UnknownFailure(message: 'Failed to fetch profile: ${e.toString()}');
    }
  }

  Future<List<MemberProfile>> getProfilesByIds(List<String> ids) async {
    try {
      if (ids.isEmpty) return const [];
      final response = await _supabase
          .from('profiles')
          .select()
          .inFilter('id', ids);

      return (response as List)
          .map((e) => MemberProfile.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw UnknownFailure(
        message: 'Failed to fetch profiles: ${e.toString()}',
      );
    }
  }
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(Supabase.instance.client);
}
