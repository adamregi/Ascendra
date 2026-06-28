import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/state/app_async_state.dart';
import '../../../../shared/widgets/async_page_state.dart';
import '../../../../shared/widgets/base_page.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../shared/widgets/paged_list_view.dart';
import '../../../../shared/widgets/search_widgets.dart';
import '../../domain/entities/member_directory_item.dart';
import '../providers/member_providers.dart';
import '../widgets/member_directory_card.dart';

class MemberDirectoryPage extends ConsumerStatefulWidget {
  const MemberDirectoryPage({super.key});

  @override
  ConsumerState<MemberDirectoryPage> createState() =>
      _MemberDirectoryPageState();
}

class _MemberDirectoryPageState extends ConsumerState<MemberDirectoryPage> {
  @override
  Widget build(BuildContext context) {
    final directoryResult = ref.watch(fetchMemberDirectoryProvider);
    final filter = ref.watch(directoryFilterProvider);

    // Convert Riverpod's AsyncValue + Result to normalized AppAsyncState
    final AppAsyncState<List<MemberDirectoryItem>> state = directoryResult.when(
      data:
          (result) => result.fold(
            (failure) => AppAsyncState.error(failure.message),
            (data) =>
                data.isEmpty
                    ? const AppAsyncState.empty()
                    : AppAsyncState.success(data),
          ),
      loading: () => const AppAsyncState.loading(),
      error: (e, st) => AppAsyncState.error(e.toString(), st),
    );

    return BasePage(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Network Directory',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SearchBarWidget(
                    hintText: 'Search members...',
                    onChanged:
                        (val) => ref
                            .read(directoryFilterProvider.notifier)
                            .updateSearch(val),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilterChipGroup<String>(
                    options: const ['Active', 'Inactive', 'Suspended'],
                    selectedValue: filter.status,
                    labelBuilder: (status) => status,
                    onSelected:
                        (status) => ref
                            .read(directoryFilterProvider.notifier)
                            .updateStatus(status),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AsyncPageState(
                state: state,
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (msg, st) => ErrorCard(
                      message: msg,
                      onRetry:
                          () => ref.invalidate(fetchMemberDirectoryProvider),
                    ),
                empty:
                    () => EmptyState(
                      title: 'No members found',
                      message:
                          'Adjust your search filters or invite new members.',
                      icon: Icons.group_off_outlined,
                      actionLabel: 'Clear Filters',
                      onAction: () {
                        ref
                            .read(directoryFilterProvider.notifier)
                            .updateSearch(null);
                        ref
                            .read(directoryFilterProvider.notifier)
                            .updateStatus(null);
                      },
                    ),
                builder:
                    (List<MemberDirectoryItem> members) => PagedListView<MemberDirectoryItem>(
                      items: members,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      itemBuilder:
                          (context, member, index) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: MemberDirectoryCard(
                              member: member,
                              onTap: () {
                                // Pass memberId via GoRouter
                                context.goNamed(
                                  'memberProfile',
                                  pathParameters: {
                                    'memberId': member.profileId,
                                  },
                                );
                              },
                            ),
                          ),
                      onRefresh: () async {
                        ref.invalidate(fetchMemberDirectoryProvider);
                      },
                      onLoadMore: () {
                        // TODO: Implement cursor pagination fetch more
                      },
                      hasMore:
                          false, // For now, assume single page or all fetched
                      isLoadingMore: false,
                      emptyState: const SizedBox.shrink(),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
