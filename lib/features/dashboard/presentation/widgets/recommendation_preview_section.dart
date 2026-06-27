import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/error_widgets.dart';
import '../../../../shared/widgets/loading_widgets.dart';
import '../../data/models/recommendation_preview_model.dart';

class RecommendationPreviewSection extends StatelessWidget {
  final AsyncValue<RecommendationPreviewModel> data;
  final VoidCallback? onRetry;

  const RecommendationPreviewSection({
    super.key,
    required this.data,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (recommendationData) {
        final allRecs = [
          ...recommendationData.promotions,
          ...recommendationData.mentorships,
          ...recommendationData.coaching,
          ...recommendationData.training,
          ...recommendationData.recognitions,
        ]..sort((a, b) => b.confidenceScore.compareTo(a.confidenceScore));

        if (allRecs.isEmpty) {
          return _buildEmptyState(context);
        }

        return _buildSuccessState(context, allRecs.take(3).toList());
      },
      loading: () => const _RecommendationSkeleton(),
      error: (err, stack) => ErrorCard(
        message: 'Failed to load AI recommendations',
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
            const Icon(Icons.psychology_alt, size: 48, color: AppColors.secondary),
            const SizedBox(height: AppSpacing.md),
            Text(
              'AI is analyzing your team. Check back later for insights.',
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

  Widget _buildSuccessState(BuildContext context, List<RecommendationItem> recs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.psychology, color: AppColors.primary, size: 20),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'AI INSIGHTS',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Column(
          children: recs.map((rec) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                rec.memberName,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${rec.confidenceScore.toInt()}% Match',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppColors.onSecondaryContainer,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rec.reasoning,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  height: 1.4,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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

class _RecommendationSkeleton extends StatelessWidget {
  const _RecommendationSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonLoader(width: 120, height: 24, borderRadius: 4),
        const SizedBox(height: AppSpacing.md),
        Column(
          children: List.generate(
            2,
            (index) => const Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoader(width: 40, height: 40, borderRadius: 20),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SkeletonLoader(width: 100, height: 16),
                              SkeletonLoader(width: 60, height: 16, borderRadius: 4),
                            ],
                          ),
                          SizedBox(height: 8),
                          SkeletonLoader(width: double.infinity, height: 12),
                          SizedBox(height: 4),
                          SkeletonLoader(width: 180, height: 12),
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
