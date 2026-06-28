import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/member_profile.dart';

class MemberAnalyticsSection extends StatelessWidget {
  final MemberAnalytics analytics;

  const MemberAnalyticsSection({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Analytics',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text('Charts will be rendered here based on:'),
          const SizedBox(height: AppSpacing.sm),
          Text('Leadership Trend: ${analytics.leadershipTrend}'),
          Text('Attendance Trend: ${analytics.attendanceTrend}'),
          Text('Task Trend: ${analytics.taskTrend}'),
        ],
      ),
    );
  }
}
