import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/metric_card.dart';
import '../../../../shared/widgets/score_ring.dart';
import '../../domain/entities/member_profile.dart';

class MemberMetricsSection extends StatelessWidget {
  final MemberProfileOverview overview;

  const MemberMetricsSection({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Leadership Score',
                value: overview.leadershipScore.toString(),
                icon: const Icon(Icons.star_outline),
                trailing: SizedBox(
                  width: 32,
                  height: 32,
                  child: ScoreRing(
                    score: overview.leadershipScore.toDouble(),
                    size: 32,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: MetricCard(
                title: 'Compliance Score',
                value: overview.complianceScore.toString(),
                icon: const Icon(Icons.shield_outlined),
                trailing: SizedBox(
                  width: 32,
                  height: 32,
                  child: ScoreRing(
                    score: overview.complianceScore.toDouble(),
                    size: 32,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Meeting Attendance',
                value: '${overview.meetingPercent.toInt()}%',
                icon: const Icon(Icons.video_camera_front_outlined),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: MetricCard(
                title: 'Task Completion',
                value: '${overview.taskPercent.toInt()}%',
                icon: const Icon(Icons.check_circle_outline),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
