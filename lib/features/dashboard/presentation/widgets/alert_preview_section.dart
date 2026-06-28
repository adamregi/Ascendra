import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../shared/widgets/loading_widgets.dart';
import '../../data/models/alert_preview_model.dart';

class AlertPreviewSection extends StatelessWidget {
  final AsyncValue<AlertPreviewModel> data;
  final VoidCallback? onRetry;

  const AlertPreviewSection({super.key, required this.data, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (alertData) {
        if (alertData.topAlerts.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildSuccessState(context, alertData.topAlerts);
      },
      loading: () => const _AlertSkeleton(),
      error:
          (err, stack) =>
              ErrorCard(message: 'Failed to load alerts', onRetry: onRetry),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return AppCard(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 48,
              color: AppColors.secondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No pending alerts! You are all caught up.',
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

  Widget _buildSuccessState(BuildContext context, List<AlertItem> alerts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ACTION REQUIRED',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Column(
          children:
              alerts.map((alert) {
                final isCritical = alert.severity.toLowerCase() == 'critical';
                final isHigh = alert.severity.toLowerCase() == 'high';
                final isWarning = isCritical || isHigh;

                final iconColor =
                    isCritical
                        ? AppColors.error
                        : (isHigh ? AppColors.error : AppColors.accentWarm);
                final bgColor =
                    isCritical
                        ? AppColors.errorContainer
                        : (isHigh
                            ? AppColors.errorContainer
                            : AppColors.secondaryContainer);

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: bgColor.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isWarning
                                ? Icons.warning_amber_rounded
                                : Icons.info_outline,
                            color: iconColor,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.title,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${alert.type} • ${alert.severity}',
                                style: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class _AlertSkeleton extends StatelessWidget {
  const _AlertSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonLoader(width: 130, height: 24, borderRadius: 4),
        const SizedBox(height: AppSpacing.md),
        Column(
          children: List.generate(
            2,
            (index) => const Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    SkeletonLoader(width: 40, height: 40, borderRadius: 20),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLoader(width: 200, height: 16),
                          SizedBox(height: 8),
                          SkeletonLoader(width: 100, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
