import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/member_profile.dart';

class MemberCompliance extends StatelessWidget {
  final MemberProfileCompliance compliance;

  const MemberCompliance({super.key, required this.compliance});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance Status',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Score: ${compliance.score}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:
                  compliance.score >= 80 ? AppColors.success : AppColors.error,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text('Reasons:'),
          const SizedBox(height: AppSpacing.xs),
          ...compliance.reasons.map(
            (reason) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, size: 8, color: AppColors.textHint),
                  const SizedBox(width: 8),
                  Expanded(child: Text(reason)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Next Improvement: ${compliance.nextImprovement}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
