import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/cache_durations.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/types/result.dart';
import '../../domain/entities/member_directory_item.dart';
import '../../domain/entities/member_directory_query.dart';
import '../../domain/entities/member_profile.dart';
import '../../domain/queries/fetch_member_directory_query.dart';
import '../../domain/queries/fetch_member_profile_query.dart';

// 1. Filter state provider
class DirectoryFilterNotifier extends StateNotifier<MemberDirectoryFilter> {
  DirectoryFilterNotifier() : super(const MemberDirectoryFilter());

  void updateSearch(String? search) {
    state = state.copyWith(searchQuery: search);
  }

  void updateStatus(String? status) {
    state = state.copyWith(status: status);
  }
}

final directoryFilterProvider =
    StateNotifierProvider<DirectoryFilterNotifier, MemberDirectoryFilter>((
      ref,
    ) {
      return DirectoryFilterNotifier();
    });

// 2. Query state provider (composes filter)
final directoryQueryProvider = Provider<MemberDirectoryQueryParams>((ref) {
  final filter = ref.watch(directoryFilterProvider);
  return MemberDirectoryQueryParams(filter: filter);
});

// 3. Directory fetch provider
final fetchMemberDirectoryProvider =
    FutureProvider<Result<List<MemberDirectoryItem>>>((ref) async {
      // Keep alive for specific duration
      final link = ref.keepAlive();
      Future.delayed(CacheDurations.directory, () => link.close());

      final queryParams = ref.watch(directoryQueryProvider);

      // TODO: Retrieve actual companyId and leaderId from auth/session provider
      const companyId = '00000000-0000-0000-0000-000000000000';
      const leaderId = '00000000-0000-0000-0000-000000000000';

      final query = sl.get<FetchMemberDirectoryQuery>();
      return query(companyId, leaderId, queryParams);
    });

// 4. Selected member provider
final selectedMemberIdProvider = StateProvider<String?>((ref) => null);

// 5. Profile fetch provider
final fetchMemberProfileProvider =
    FutureProvider.family<Result<MemberProfile>, String>((
      ref,
      profileId,
    ) async {
      // Keep alive for specific duration
      final link = ref.keepAlive();
      Future.delayed(CacheDurations.profile, () => link.close());

      final query = sl.get<FetchMemberProfileQuery>();
      return query(profileId);
    });
