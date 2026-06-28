import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../providers/tasks_providers.dart';

/// The hero card at the top of the Tasks dashboard showing team execution health.
/// Mirrors the reference: tasks_command_center_leader
class TaskExecutionHealthCard extends StatelessWidget {
  final TaskDashboardSummary summary;

  const TaskExecutionHealthCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final healthPercent = summary.completionPercent.clamp(0, 100).toDouble();
    final onTrack = summary.completedCount + summary.inProgressCount;
    final needsAttention = summary.overdueCount;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular progress ring
          SizedBox(
            width: 96,
            height: 96,
            child: CustomPaint(
              painter: _HealthRingPainter(healthPercent / 100),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${healthPercent.toInt()}%',
                      style: const TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      'HEALTH',
                      style: TextStyle(
                        fontFamily: 'Hanken Grotesk',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Team Execution Health',
                  style: TextStyle(
                    fontFamily: 'Newsreader',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${summary.totalCount} Active Tasks, $onTrack On Track, $needsAttention Overdue',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                // Segmented progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  child: SizedBox(
                    height: 6,
                    child: Row(
                      children: [
                        _segment(
                          summary.completedCount,
                          summary.totalCount,
                          const Color(0xFF10b981),
                        ),
                        _segment(
                          summary.inProgressCount,
                          summary.totalCount,
                          const Color(0xFF4f46e5),
                        ),
                        _segment(
                          summary.openCount,
                          summary.totalCount,
                          const Color(0xFFf59e0b),
                        ),
                        _segment(
                          summary.overdueCount,
                          summary.totalCount,
                          AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _segment(int count, int total, Color color) {
    if (total == 0 || count == 0) return const SizedBox.shrink();
    return Expanded(flex: count, child: Container(color: color));
  }
}

class _HealthRingPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0

  _HealthRingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 6.0;

    // Background ring
    final bgPaint =
        Paint()
          ..color = AppColors.surfaceVariant
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc
    final fgPaint =
        Paint()
          ..color = const Color(0xFF10b981)
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
  bool shouldRepaint(covariant _HealthRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
