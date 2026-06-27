import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/base_page.dart';
import '../../../../core/responsive/responsive_padding.dart';
import '../../../../core/constants/app_spacing.dart';

import '../widgets/executive_overview_card.dart';
import '../widgets/leadership_pipeline_preview.dart';
import '../widgets/alert_preview_section.dart';
import '../widgets/recommendation_preview_section.dart';

import '../../providers/dashboard_providers.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> with WidgetsBindingObserver {
  DateTime? _lastRefresh;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    ref.invalidate(executiveOverviewProvider);
    ref.invalidate(alertPreviewProvider);
    ref.invalidate(recommendationPreviewProvider);
    ref.invalidate(leadershipPipelineProvider);
  }

  @override
  Widget build(BuildContext context) {
    final overviewData = ref.watch(executiveOverviewProvider);
    final alertData = ref.watch(alertPreviewProvider);
    final recommendationData = ref.watch(recommendationPreviewProvider);
    final pipelineData = ref.watch(leadershipPipelineProvider);

    return BasePage(
      title: 'Analytics',
      body: RefreshIndicator(
        onRefresh: () async {
          _lastRefresh = DateTime.now();
          _invalidateAll();
        },
        child: ResponsivePadding(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            children: [
              ExecutiveOverviewCard(
                data: overviewData,
                onRetry: () => ref.invalidate(executiveOverviewProvider),
              ),
              const SizedBox(height: AppSpacing.xl),
              AlertPreviewSection(
                data: alertData,
                onRetry: () => ref.invalidate(alertPreviewProvider),
              ),
              const SizedBox(height: AppSpacing.xl),
              RecommendationPreviewSection(
                data: recommendationData,
                onRetry: () => ref.invalidate(recommendationPreviewProvider),
              ),
              const SizedBox(height: AppSpacing.xl),
              LeadershipPipelinePreview(
                data: pipelineData,
                onRetry: () => ref.invalidate(leadershipPipelineProvider),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
