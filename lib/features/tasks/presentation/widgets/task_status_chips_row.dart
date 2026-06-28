import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../providers/tasks_providers.dart';

/// Horizontally scrollable status chips row matching the reference design.
class TaskStatusChipsRow extends StatelessWidget {
  final TaskDashboardSummary summary;

  const TaskStatusChipsRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _StatusChip(
            label: 'Pending',
            count: summary.openCount,
            icon: LucideIcons.clock,
            color: const Color(0xFF64748b),
            bgColor: AppColors.surfaceContainerLowest,
          ),
          const SizedBox(width: AppSpacing.sm),
          _StatusChip(
            label: 'In Progress',
            count: summary.inProgressCount,
            icon: LucideIcons.refreshCw,
            color: const Color(0xFF4f46e5),
            bgColor: AppColors.surfaceContainerLowest,
            hasAccent: true,
          ),
          const SizedBox(width: AppSpacing.sm),
          _StatusChip(
            label: 'Completed',
            count: summary.completedCount,
            icon: LucideIcons.checkCircle,
            color: const Color(0xFF10b981),
            bgColor: const Color(0xFF10b981).withValues(alpha: 0.05),
          ),
          const SizedBox(width: AppSpacing.sm),
          _StatusChip(
            label: 'Overdue',
            count: summary.overdueCount,
            icon: LucideIcons.alertTriangle,
            color: AppColors.error,
            bgColor: AppColors.error.withValues(alpha: 0.08),
            isPulsing: summary.overdueCount > 0,
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final bool hasAccent;
  final bool isPulsing;

  const _StatusChip({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
    required this.bgColor,
    this.hasAccent = false,
    this.isPulsing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border:
            hasAccent
                ? Border(left: BorderSide(color: AppColors.primary, width: 3))
                : Border.all(
                  color: AppColors.borderSubtle.withValues(alpha: 0.3),
                ),
        boxShadow:
            hasAccent
                ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
                : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Hanken Grotesk',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$count',
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: isPulsing ? color : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
