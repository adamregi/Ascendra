import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';

class AttendanceSummaryCard extends StatelessWidget {
  final int registered;
  final int joined;
  final int absent;
  final double attendancePercentage;

  const AttendanceSummaryCard({
    super.key,
    required this.registered,
    required this.joined,
    required this.absent,
    required this.attendancePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Summary',
            style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(child: _buildMetric('Registered', registered.toString())),
              Container(width: 1, height: 40, color: AppColors.borderSubtle),
              Expanded(child: _buildMetric('Joined', joined.toString())),
              Container(width: 1, height: 40, color: AppColors.borderSubtle),
              Expanded(child: _buildMetric('Absent', absent.toString())),
              Container(width: 1, height: 40, color: AppColors.borderSubtle),
              Expanded(
                child: _buildMetric(
                  'Rate', 
                  '${attendancePercentage.toStringAsFixed(0)}%',
                  valueColor: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, {Color valueColor = AppColors.primary}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTypography.h2.copyWith(color: valueColor),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label.toUpperCase(),
          style: AppTypography.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
