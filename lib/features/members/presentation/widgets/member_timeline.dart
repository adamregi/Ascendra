import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/timeline_item.dart';
import '../../domain/entities/member_profile.dart';

class MemberTimeline extends StatelessWidget {
  final List<MemberTimelineEvent> events;

  const MemberTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(child: Text('No recent activity'));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return TimelineItem(
          title: event.title,
          subtitle: event.description,
          trailing: Text(
            '\${event.timestamp.month}/\${event.timestamp.day}/\${event.timestamp.year}',
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          isLast: index == events.length - 1,
          icon: _getIconForType(event.type),
        );
      },
    );
  }

  IconData _getIconForType(TimelineEventType type) {
    switch (type) {
      case TimelineEventType.meeting:
        return Icons.video_camera_front;
      case TimelineEventType.task:
      case TimelineEventType.proof:
        return Icons.check_circle;
      case TimelineEventType.followup:
        return Icons.notifications;
      case TimelineEventType.recognition:
      case TimelineEventType.promotion:
        return Icons.emoji_events;
      case TimelineEventType.warning:
      case TimelineEventType.suspension:
      case TimelineEventType.termination:
        return Icons.warning;
      case TimelineEventType.note:
      default:
        return Icons.note;
    }
  }

}
