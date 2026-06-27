import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../shared/widgets/loading_widgets.dart';
import '../../data/models/executive_overview_model.dart';

class ExecutiveOverviewCard extends StatelessWidget {
  final AsyncValue<ExecutiveOverviewModel> data;
  final VoidCallback? onRetry;

  const ExecutiveOverviewCard({
    super.key,
    required this.data,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (overview) {
        if (overview.health == null && overview.message != null) {
          return _buildEmptyState(context, overview.message!);
        }
        return _buildSuccessState(context, overview);
      },
      loading: () => const _ExecutiveOverviewSkeleton(),
      error: (err, stack) => ErrorCard(
        message: 'Failed to load executive overview',
        onRetry: onRetry,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return AppCard(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const Icon(Icons.analytics_outlined, size: 48, color: AppColors.onSurfaceVariant),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, ExecutiveOverviewModel overview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Health & Growth KPIs
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildKpiCard(
                context,
                title: 'Team Size',
                value: '${overview.health?.teamSize ?? 0}',
                icon: Icons.groups,
                trend: '+${(overview.growth?.teamGrowthScore ?? 0).toInt()}%',
                isPositive: (overview.growth?.teamGrowthScore ?? 0) >= 0,
              ),
              const SizedBox(width: AppSpacing.sm),
              _buildKpiCard(
                context,
                title: 'Attendance',
                value: '${(overview.health?.attendanceRate ?? 0).toInt()}%',
                icon: Icons.check_circle_outline,
                trend: null,
                isPositive: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              _buildKpiCard(
                context,
                title: 'Tasks',
                value: '${(overview.health?.completionRate ?? 0).toInt()}%',
                icon: Icons.task_alt,
                trend: '+${(overview.growth?.taskGrowthScore ?? 0).toInt()}%',
                isPositive: (overview.growth?.taskGrowthScore ?? 0) >= 0,
              ),
              const SizedBox(width: AppSpacing.sm),
              _buildKpiCard(
                context,
                title: 'Risk Level',
                value: '${overview.risk?.critical ?? 0}',
                icon: Icons.warning_amber_rounded,
                trend: null,
                isPositive: false,
                isError: (overview.risk?.critical ?? 0) > 0,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        
        // 2. Pending Actions Summary
        if (overview.pendingActions != null && overview.pendingActions!.total > 0)
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.priority_high, color: AppColors.error),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TODAY\'S PRIORITY',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${overview.pendingActions!.total} pending actions require your attention',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, color: AppColors.primary),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildKpiCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    String? trend,
    required bool isPositive,
    bool isError = false,
  }) {
    final semanticLabel = '$title is $value. ${trend != null ? "Trend is $trend." : ""}';
    return Semantics(
      label: semanticLabel,
      button: false,
      child: ExcludeSemantics(
        child: Container(
          width: 140,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isError ? AppColors.errorContainer.withValues(alpha: 0.3) : AppColors.surface,
        border: Border.all(
          color: isError ? AppColors.error.withValues(alpha: 0.3) : AppColors.borderSubtle,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isError ? AppColors.error : AppColors.onSurfaceVariant,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: isError ? AppColors.error : AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              if (trend != null)
                Row(
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 16,
                      color: isPositive ? AppColors.secondary : AppColors.error,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      trend,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isPositive ? AppColors.secondary : AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                )
              else
                Icon(
                  icon,
                  size: 20,
                  color: isError ? AppColors.error : AppColors.secondary,
                ),
            ],
          ),
        ],
      ),
    )));
  }
}

class _ExecutiveOverviewSkeleton extends StatelessWidget {
  const _ExecutiveOverviewSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: SkeletonLoader(
                  width: 140,
                  height: 110,
                  borderRadius: 12,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const SkeletonLoader(
          width: double.infinity,
          height: 80,
          borderRadius: 12,
        ),
      ],
    );
  }
}
