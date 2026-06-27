import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/providers/auth_state_provider.dart';
import '../data/user_repository.dart';
import '../../../shared/models/member_profile.dart';

part 'profile_provider.g.dart';

@riverpod
Future<MemberProfile?> profile(Ref ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repository = ref.watch(userRepositoryProvider);
  return repository.getProfile(user.id);
}

@riverpod
Future<String?> companyId(Ref ref) async {
  final profileAsync = ref.watch(profileProvider);
  return profileAsync.value?.companyId;
}

@riverpod
Future<String?> permissions(Ref ref) async {
  final profileAsync = ref.watch(profileProvider);
  return profileAsync.value?.role;
}
