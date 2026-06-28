import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/meeting.dart';
import 'meeting_countdown_widget.dart';

class MeetingHeaderCard extends StatelessWidget {
  final Meeting meeting;
  final int expectedAttendees;

  const MeetingHeaderCard({
    super.key,
    required this.meeting,
    required this.expectedAttendees,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000), // 5% black
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Top accented border
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 4,
            child: Container(color: AppColors.primary),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              children: [
                // Only show countdown if scheduled in the future
                if (meeting.scheduledAt.isAfter(DateTime.now()))
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                    child: MeetingCountdownWidget(
                      startTime: meeting.scheduledAt,
                    ),
                  ),

                // Bento Grid Stats
                Container(
                  padding: const EdgeInsets.only(top: AppSpacing.lg),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.borderSubtle),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _buildStatItem('Goal', '95%')),
                      Container(
                        width: 1,
                        height: 48,
                        color: AppColors.borderSubtle,
                      ),
                      Expanded(
                        child: _buildStatItem(
                          'Expected',
                          expectedAttendees.toString(),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 48,
                        color: AppColors.borderSubtle,
                      ),
                      Expanded(
                        child: _buildStatItem(
                          'Duration',
                          '${meeting.durationMinutes ?? 0}m',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: AppTypography.h2.copyWith(color: AppColors.primary)),
      ],
    );
  }
}
