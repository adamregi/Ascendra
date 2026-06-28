import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../shared/widgets/loading_widgets.dart';
import '../../data/models/leadership_pipeline_model.dart';

class LeadershipPipelinePreview extends StatelessWidget {
  final AsyncValue<LeadershipPipelineModel> data;
  final VoidCallback? onRetry;

  const LeadershipPipelinePreview({
    super.key,
    required this.data,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (pipeline) {
        final allLeaders = [
          ...pipeline.futureLeaders,
          ...pipeline.emergingLeaders,
        ];

        if (allLeaders.isEmpty) {
          return _buildEmptyState(context);
        }

        return _buildSuccessState(context, allLeaders.take(4).toList());
      },
      loading: () => const _PipelineSkeleton(),
      error:
          (err, stack) => ErrorCard(
            message: 'Failed to load leadership pipeline',
            onRetry: onRetry,
          ),
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
              Icons.psychology,
              size: 48,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No upcoming leaders identified yet.',
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

  Widget _buildSuccessState(
    BuildContext context,
    List<PipelineMember> leaders,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LEADERSHIP PIPELINE',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          padding: EdgeInsets.zero,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leaders.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final member = leaders[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                leading: AppAvatar(name: member.fullName, radius: 20),
                title: Text(
                  member.fullName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                subtitle: Text(
                  member.leadershipBand,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    member.leadershipScore.toInt().toString(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PipelineSkeleton extends StatelessWidget {
  const _PipelineSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonLoader(width: 150, height: 24, borderRadius: 4),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => const Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    SkeletonLoader(width: 40, height: 40, borderRadius: 20),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLoader(width: 120, height: 16),
                          SizedBox(height: 8),
                          SkeletonLoader(width: 80, height: 12),
                        ],
                      ),
                    ),
                    SkeletonLoader(width: 30, height: 24, borderRadius: 12),
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
