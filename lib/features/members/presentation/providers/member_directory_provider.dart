import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/extensions/ref_extensions.dart';
import '../../data/repositories/member_repository_impl.dart';
import '../../domain/entities/member_directory_item.dart';
import '../../domain/repositories/member_repositories.dart';
part 'member_directory_provider.g.dart';

@riverpod
MemberRepository memberRepository(MemberRepositoryRef ref) {
  return MemberRepositoryImpl(Supabase.instance.client);
}

// Search Query State
@riverpod
class MemberSearchQuery extends _$MemberSearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

// Filters State
@riverpod
class MemberStatusFilter extends _$MemberStatusFilter {
  @override
  String? build() => null;

  void update(String? status) => state = status;
}

@riverpod
class MemberPromotionReadyFilter extends _$MemberPromotionReadyFilter {
  @override
  bool? build() => null;

  void update(bool? ready) => state = ready;
}

@riverpod
class MemberHighRiskFilter extends _$MemberHighRiskFilter {
  @override
  bool? build() => null;

  void update(bool? risk) => state = risk;
}

@riverpod
Future<List<MemberDirectoryItem>> memberDirectory(
  MemberDirectoryRef ref,
) async {
  // 5-minute TTL
  ref.cacheFor(const Duration(minutes: 5));

  final repo = ref.watch(memberRepositoryProvider);

  // Example of how we might fetch current user's leader ID, etc.
  // In a real app we'd watch the auth session.
  final leaderId = Supabase.instance.client.auth.currentUser?.id;

  final searchQuery = ref.watch(memberSearchQueryProvider);
  final status = ref.watch(memberStatusFilterProvider);
  final promotionReady = ref.watch(memberPromotionReadyFilterProvider);
  final highRisk = ref.watch(memberHighRiskFilterProvider);

  final query = searchQuery.trim().isEmpty ? null : searchQuery.trim();

  final results = await repo.getMemberDirectory(
    leaderId: leaderId,
    searchQuery: query,
    status: status,
    promotionReady: promotionReady,
    highRisk: highRisk,
  );
  
  return results.map((m) => MemberDirectoryItem(
    profileId: m.profileId,
    firstName: m.firstName,
    lastName: m.lastName,
    avatarUrl: m.avatarUrl,
    distributorId: m.distributorId ?? '',
    status: m.status,
    rank: m.rank,
    parentId: null, // Model doesn't have parentId
    leaderName: m.leaderName,
    meetingPercent: m.meetingPercent.toDouble(),
    taskPercent: m.taskPercent.toDouble(),
    riskLevel: m.riskLevel,
    isPromotionReady: m.isPromotionReady,
    recognitionCount: m.recognitionCount,
  )).toList();
}
