import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_radius.dart';

class TaskActivityTimeline extends StatelessWidget {
  const TaskActivityTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity Timeline',
            style: TextStyle(
              fontFamily: 'Newsreader',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildTimelineItem(
            dateStr: 'Today, 09:41 AM',
            content: 'Task reached 70% completion',
            isRecent: true,
            isLast: false,
          ),
          _buildTimelineItem(
            dateStr: 'Yesterday, 14:20 PM',
            content: 'Reminder sent to Branch Gamma',
            isRecent: false,
            isLast: false,
          ),
          _buildTimelineItem(
            dateStr: 'Oct 12, 08:00 AM',
            content: 'Task Assigned to 42 members\nCreated by Alex Rivera',
            isRecent: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String dateStr,
    required String content,
    required bool isRecent,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Node and Line
          SizedBox(
            width: 24,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned(
                    top: 16,
                    bottom: 0,
                    child: Container(width: 2, color: AppColors.surfaceVariant),
                  ),
                Positioned(
                  top: 4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color:
                          isRecent
                              ? AppColors.secondary
                              : AppColors.borderSubtle,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.surfaceContainerLowest,
                        width: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateStr,
                    style: const TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRecent ? FontWeight.w500 : FontWeight.w400,
                      color: isRecent ? AppColors.primary : AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
