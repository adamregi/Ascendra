import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/meeting_status_filter.dart';

/// Context-aware empty state tailored to the selected filter.
class MeetingEmptyState extends StatelessWidget {
  final MeetingStatusFilter filter;

  const MeetingEmptyState({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String title;
    String message;

    switch (filter) {
      case MeetingStatusFilter.upcoming:
        icon = Icons.event_available_outlined;
        title = 'No Upcoming Meetings';
        message = 'Schedule your first meeting.';
        break;
      case MeetingStatusFilter.live:
        icon = Icons.videocam_off_outlined;
        title = 'No Live Meetings';
        message = 'No meetings are live right now.';
        break;
      case MeetingStatusFilter.past:
        icon = Icons.history_outlined;
        title = 'No Past Meetings';
        message = 'Completed meetings will appear here.';
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Icon(
              icon,
              size: 48,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppTypography.h3.copyWith(color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
