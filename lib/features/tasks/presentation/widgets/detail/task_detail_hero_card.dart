import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_priority.dart';
import '../../../domain/entities/task_status.dart';

class TaskDetailHeroCard extends StatelessWidget {
  final Task task;
  final Map<String, int> stats;

  const TaskDetailHeroCard({
    super.key,
    required this.task,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final total = stats['assigned'] ?? 0;
    final completed = stats['completed'] ?? 0;
    final completionPercent =
        total > 0 ? (completed / total * 100).toDouble() : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildStatusChip(),
                    const SizedBox(width: AppSpacing.sm),
                    if (task.priority == 'high' || task.priority == 'urgent')
                      _buildPriorityChip(),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  task.title,
                  style: const TextStyle(
                    fontFamily: 'Newsreader',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (task.dueDate != null)
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.calendar,
                        size: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(task.dueDate!),
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          // Circular Progress Ring
          SizedBox(
            width: 72,
            height: 72,
            child: CustomPaint(
              painter: _DetailRingPainter(completionPercent / 100),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${completionPercent.toInt()}',
                      style: const TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      '%',
                      style: TextStyle(
                        fontFamily: 'Hanken Grotesk',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            task.status.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.onSecondaryContainer,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.errorContainer),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.alertCircle, size: 12, color: AppColors.error),
          const SizedBox(width: 4),
          Text(
            task.priority.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Due ${months[date.month - 1]} ${date.day}';
  }
}

class _DetailRingPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0

  _DetailRingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    const strokeWidth = 8.0;

    // Background ring
    final bgPaint =
        Paint()
          ..color = AppColors.surfaceContainer
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc
    final fgPaint =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DetailRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
