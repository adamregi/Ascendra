import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/meeting.dart';
import 'meeting_status_badge.dart';

/// Compact card for a scheduled (upcoming) meeting.
class UpcomingMeetingCard extends StatelessWidget {
  final Meeting meeting;
  final VoidCallback? onTap;

  const UpcomingMeetingCard({
    super.key,
    required this.meeting,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.MMMd();
    final timeFormat = DateFormat.jm();
    final date = dateFormat.format(meeting.scheduledAt.toLocal());
    final time = timeFormat.format(meeting.scheduledAt.toLocal());

    return Semantics(
      label: 'Upcoming meeting: ${meeting.title} on $date at $time',
      child: Material(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderSubtle),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Row(
              children: [
                // Date column
                Container(
                  width: 52,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat.MMM().format(meeting.scheduledAt.toLocal()).toUpperCase(),
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '${meeting.scheduledAt.toLocal().day}',
                        style: const TextStyle(
                          fontFamily: 'JetBrains Mono',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting.title,
                        style: AppTypography.labelMd.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 14, color: AppColors.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                          if (meeting.durationMinutes != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              '${meeting.durationMinutes} min',
                              style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Status badge
                MeetingStatusBadge(status: meeting.meetingStatus),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
