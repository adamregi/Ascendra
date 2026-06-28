import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_typography.dart';
import '../../data/models/meeting_dashboard_summary.dart';
import '../../../../shared/widgets/responsive_metrics_grid.dart';

/// Leadership snapshot card displaying meeting KPIs.
///
/// Consumes a pre-computed [MeetingDashboardSummary] — no data derivation here.
class MeetingSnapshotCard extends StatelessWidget {
  final MeetingDashboardSummary summary;

  const MeetingSnapshotCard({super.key, required this.summary});

  static const _teal = Color(0xFF14B8A6);
  static const _emerald = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Meeting leadership snapshot',
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 24, left: 24, right: 24),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LEADERSHIP SNAPSHOT',
              style: AppTypography.headlineSm.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            ResponsiveMetricsGrid(
              spacing: 16.0,
              metrics: [
                MetricCardData(
                  indicator: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: _teal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  label: 'Live',
                  value: '${summary.liveCount}',
                ),
                MetricCardData(
                  indicator: Icon(Icons.calendar_today, size: 16, color: AppColors.onSurfaceVariant),
                  label: 'Upcoming',
                  value: '${summary.upcomingCount}',
                ),
                MetricCardData(
                  indicator: Icon(Icons.group, size: 16, color: AppColors.onSurfaceVariant),
                  label: 'Attendance',
                  value: '${summary.averageAttendancePercent.round()}',
                  suffix: '%',
                ),
                MetricCardData(
                  indicator: Icon(Icons.check_circle, size: 16, color: _emerald),
                  label: 'Completion',
                  value: '${summary.completionPercent.round()}',
                  suffix: '%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

