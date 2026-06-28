import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/state/app_async_state.dart';
import '../../../../shared/widgets/async_page_state.dart';
import '../../../../shared/widgets/base_page.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../providers/member_providers.dart';
import '../widgets/member_analytics.dart';
import '../widgets/member_compliance.dart';
import '../widgets/member_hero.dart';
import '../widgets/member_metrics_section.dart';
import '../widgets/member_recognition.dart';
import '../widgets/member_timeline.dart';

class MemberProfilePage extends ConsumerStatefulWidget {
  final String memberId;

  const MemberProfilePage({super.key, required this.memberId});

  @override
  ConsumerState<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends ConsumerState<MemberProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileResult = ref.watch(
      fetchMemberProfileProvider(widget.memberId),
    );

    final state = profileResult.when(
      data:
          (result) => result.fold(
            (failure) => AppAsyncState.error(failure.message),
            (data) => AppAsyncState.success(data),
          ),
      loading: () => const AppAsyncState.loading(),
      error: (e, st) => AppAsyncState.error(e.toString(), st),
    );

    return BasePage(
      title: 'Member Profile',
      body: AsyncPageState(
        state: state,
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (msg, st) => ErrorCard(
              message: msg,
              onRetry:
                  () => ref.invalidate(
                    fetchMemberProfileProvider(widget.memberId),
                  ),
            ),
        empty:
            () => const EmptyState(
              title: 'Not Found',
              message: 'The requested member could not be found.',
              icon: Icons.person_off_outlined,
            ),
        builder: (profile) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(child: MemberHero(heroData: profile.hero)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: MemberMetricsSection(overview: profile.overview),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textSecondary,
                      indicatorColor: AppColors.primary,
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Timeline'),
                        Tab(text: 'Compliance'),
                        Tab(text: 'Recognition'),
                        Tab(text: 'Analytics'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                // Overview Tab
                ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    MemberTimeline(
                      events: profile.timeline.take(3).toList(),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    MemberCompliance(compliance: profile.compliance),
                  ],
                ),
                // Timeline Tab (Lazy loaded by TabBarView automatically)
                ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [MemberTimeline(events: profile.timeline)],
                ),
                // Compliance Tab
                ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [MemberCompliance(compliance: profile.compliance)],
                ),
                // Recognition Tab
                ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    MemberRecognitionList(recognitions: profile.recognition),
                  ],
                ),
                // Analytics Tab
                ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    MemberAnalyticsSection(analytics: profile.analytics),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
