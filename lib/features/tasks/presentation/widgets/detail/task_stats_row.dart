import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_radius.dart';

class TaskStatsRow extends StatelessWidget {
  final Map<String, int> stats;

  const TaskStatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(
          label: 'Assigned',
          count: stats['assigned'] ?? 0,
          color: AppColors.primary,
          bgColor: AppColors.surfaceContainerLow,
        ),
        const SizedBox(width: AppSpacing.sm),
        _buildStatCard(
          label: 'Completed',
          count: stats['completed'] ?? 0,
          color: AppColors.secondary,
          bgColor: AppColors.surfaceContainerLow,
        ),
        const SizedBox(width: AppSpacing.sm),
        _buildStatCard(
          label: 'In Progress',
          count: stats['inProgress'] ?? 0,
          color: AppColors.onSurface,
          bgColor: AppColors.surfaceContainerLow,
        ),
        const SizedBox(width: AppSpacing.sm),
        _buildStatCard(
          label: 'Overdue',
          count: stats['overdue'] ?? 0,
          color: AppColors.error,
          bgColor: AppColors.errorContainer,
          borderColor: AppColors.errorContainer.withValues(alpha: 0.5),
          textColor: AppColors.error,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required int count,
    required Color color,
    required Color bgColor,
    Color? borderColor,
    Color? textColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: borderColor ?? AppColors.surfaceVariant),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Hanken Grotesk',
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: textColor ?? AppColors.onSurfaceVariant,
                letterSpacing: 1.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$count',
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
