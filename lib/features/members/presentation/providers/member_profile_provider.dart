import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/extensions/ref_extensions.dart';
import '../../data/models/member_profile_view_model.dart';
import '../../data/repositories/member_profile_repository_impl.dart';
import '../../domain/repositories/member_repositories.dart';

part 'member_profile_provider.g.dart';

@riverpod
MemberProfileRepository memberProfileRepository(
  MemberProfileRepositoryRef ref,
) {
  return MemberProfileRepositoryImpl(Supabase.instance.client);
}

@riverpod
Future<MemberProfileViewModel> memberProfile(
  MemberProfileRef ref,
  String profileId,
) async {
  // 5-minute TTL to match established patterns
  ref.cacheFor(const Duration(minutes: 5));

  final repo = ref.watch(memberProfileRepositoryProvider);
  return repo.getMemberProfile(profileId);
}
