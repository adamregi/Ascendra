import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/meeting.dart';
import 'meeting_status_badge.dart';

/// Hero card for a live meeting — the most prominent element in the list.
class LiveMeetingCard extends StatelessWidget {
  final Meeting meeting;
  final VoidCallback? onEnter;
  final VoidCallback? onViewParticipants;

  const LiveMeetingCard({
    super.key,
    required this.meeting,
    this.onEnter,
    this.onViewParticipants,
  });

  static const _teal = Color(0xFF14B8A6);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.jm();
    final startTime = timeFormat.format(meeting.scheduledAt.toLocal());
    final endTime =
        meeting.durationMinutes != null
            ? timeFormat.format(
              meeting.scheduledAt
                  .add(Duration(minutes: meeting.durationMinutes!))
                  .toLocal(),
            )
            : null;

    return Semantics(
      label: 'Live meeting: ${meeting.title}',
      child: Container(
        padding: const EdgeInsets.all(24),
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
            // Live badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    border: Border.all(color: _teal.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LivePulseIndicator(size: 8),
                      const SizedBox(width: 8),
                      Text(
                        'LIVE NOW',
                        style: TextStyle(
                          fontFamily: 'JetBrains Mono',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _teal,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: AppColors.onSurfaceVariant,
                  ),
                  onPressed: () {},
                  constraints: const BoxConstraints(
                    minHeight: 48,
                    minWidth: 48,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              meeting.title,
              style: const TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            // Time
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 18,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  endTime != null ? '$startTime – $endTime' : startTime,
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Actions
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: onEnter,
                      icon: const Icon(Icons.login, size: 20),
                      label: const Text('Enter Meeting'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        textStyle: AppTypography.labelMd,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: onViewParticipants,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.borderSubtle),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        textStyle: AppTypography.labelMd,
                      ),
                      child: const Text('View Participants'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
