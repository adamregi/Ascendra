import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/base_page.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../core/responsive/responsive_padding.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../profile/providers/profile_provider.dart';
import '../providers/meetings_providers.dart';
import '../widgets/meeting_snapshot_card.dart';
import '../widgets/meeting_status_filter.dart';
import '../widgets/live_meeting_card.dart';
import '../widgets/upcoming_meeting_card.dart';
import '../widgets/past_meeting_card.dart';
import '../widgets/meeting_empty_state.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/meeting.dart';

class MeetingsPage extends ConsumerStatefulWidget {
  const MeetingsPage({super.key});

  @override
  ConsumerState<MeetingsPage> createState() => _MeetingsPageState();
}

class _MeetingsPageState extends ConsumerState<MeetingsPage>
    with WidgetsBindingObserver {
  DateTime? _lastRefresh;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshWithThrottling();
    }
  }

  void _refreshWithThrottling() {
    final now = DateTime.now();
    if (_lastRefresh == null || now.difference(_lastRefresh!).inSeconds > 60) {
      _lastRefresh = now;
      _invalidateAll();
    }
  }

  void _invalidateAll() {
    ref.invalidate(upcomingMeetingsProvider);
    ref.invalidate(meetingHistoryProvider);
  }

  void _onSearchChanged(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(meetingSearchQueryProvider.notifier).update(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(meetingDashboardSummaryProvider);
    final filter = ref.watch(selectedMeetingFilterProvider);
    final meetingsAsync = ref.watch(searchedMeetingsProvider);
    final permissionsAsync = ref.watch(permissionsProvider);

    final canSchedule =
        permissionsAsync.value == 'leader' || permissionsAsync.value == 'admin';

    return BasePage(
      title: 'Meetings',
      floatingActionButton:
          canSchedule
              ? FloatingActionButton(
                onPressed: () {
                  // Navigate to schedule form (M3.2)
                },
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                child: const Icon(Icons.add),
              )
              : null,
      body: RefreshIndicator(
        onRefresh: () async {
          _lastRefresh = DateTime.now();
          _invalidateAll();
        },
        child: ResponsivePadding(
          child: CustomScrollView(
            slivers: [
              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: TextField(
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search meetings...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: AppColors.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
              ),

              // Snapshot Card
              SliverToBoxAdapter(
                child: summaryAsync.when(
                  data:
                      (summary) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                        child: MeetingSnapshotCard(summary: summary),
                      ),
                  loading:
                      () => const Padding(
                        padding: EdgeInsets.only(bottom: AppSpacing.xl),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  error:
                      (e, st) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                        child: ErrorCard(
                          message: 'Failed to load summary',
                          onRetry: _invalidateAll,
                        ),
                      ),
                ),
              ),

              // Filter Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                  child: MeetingStatusFilterBar(
                    selected: filter,
                    onSelected: (newFilter) {
                      ref
                          .read(selectedMeetingFilterProvider.notifier)
                          .select(newFilter);
                    },
                  ),
                ),
              ),

              // Meeting List
              meetingsAsync.when(
                data: (meetings) {
                  if (meetings.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: MeetingEmptyState(filter: filter),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final meeting = meetings[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _buildMeetingCard(context, meeting),
                      );
                    }, childCount: meetings.length),
                  );
                },
                loading:
                    () => const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                error:
                    (e, st) => SliverFillRemaining(
                      child: ErrorCard(
                        message: 'Failed to load meetings',
                        onRetry: _invalidateAll,
                      ),
                    ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 80), // FAB padding
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingCard(BuildContext context, Meeting meeting) {
    if (meeting.meetingStatus == MeetingStatus.live) {
      return LiveMeetingCard(
        meeting: meeting,
        onEnter: () {
          // Navigate to live meeting (M3.3)
        },
        onViewParticipants: () {
          // Navigate to meeting details (M3.2)
        },
      );
    } else if (meeting.meetingStatus == MeetingStatus.scheduled) {
      return UpcomingMeetingCard(
        meeting: meeting,
        onTap: () {
          // Navigate to meeting details (M3.2)
        },
      );
    } else {
      return PastMeetingCard(
        meeting: meeting,
        attendancePercent: 0, // Enriched in M3.2
        onTap: () {
          // Navigate to meeting details (M3.2)
        },
      );
    }
  }
}
