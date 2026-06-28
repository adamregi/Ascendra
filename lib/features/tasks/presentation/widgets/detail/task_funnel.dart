import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_radius.dart';

class TaskFunnel extends StatelessWidget {
  final Map<String, int> stats;

  const TaskFunnel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final assigned = stats['assigned'] ?? 0;
    final started = stats['inProgress'] ?? 0;
    final needsReview = stats['needsReview'] ?? 0;
    final completed = stats['completed'] ?? 0;

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
            'Conversion Funnel',
            style: TextStyle(
              fontFamily: 'Newsreader',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Stack(
            children: [
              // Vertical connecting line
              Positioned(
                left: 15,
                top: 16,
                bottom: 16,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.secondaryContainer,
                        AppColors.borderSubtle,
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  _FunnelStep(
                    icon: LucideIcons.users,
                    label: 'Assigned',
                    value: assigned,
                    total: assigned,
                    isFirst: true,
                  ),
                  _FunnelStep(
                    icon: LucideIcons.play,
                    label: 'Started',
                    value: started + needsReview + completed,
                    total: assigned,
                  ),
                  _FunnelStep(
                    icon: LucideIcons.fileText,
                    label: 'Proof Submitted',
                    value: needsReview + completed,
                    total: assigned,
                  ),
                  _FunnelStep(
                    icon: LucideIcons.checkCircle,
                    label: 'Completed',
                    value: completed,
                    total: assigned,
                    isLast: true,
                    isSuccess: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FunnelStep extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final int total;
  final bool isFirst;
  final bool isLast;
  final bool isSuccess;

  const _FunnelStep({
    required this.icon,
    required this.label,
    required this.value,
    required this.total,
    this.isFirst = false,
    this.isLast = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = total > 0 ? (value / total) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon node
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color:
                  isSuccess
                      ? AppColors.secondaryContainer
                      : AppColors.surfaceContainer,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.surfaceContainerLowest,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: 16,
              color:
                  isSuccess
                      ? AppColors.onSecondaryContainer
                      : AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isFirst || isSuccess
                                ? FontWeight.w500
                                : FontWeight.w400,
                        color:
                            isSuccess
                                ? AppColors.secondary
                                : (isFirst
                                    ? AppColors.primary
                                    : AppColors.onSurface),
                      ),
                    ),
                    Text(
                      '$value',
                      style: TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontSize: 14,
                        fontWeight:
                            isSuccess
                                ? FontWeight.w600
                                : (isFirst ? FontWeight.w500 : FontWeight.w400),
                        color:
                            isSuccess
                                ? AppColors.secondary
                                : (isFirst
                                    ? AppColors.primary
                                    : AppColors.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
                if (!isFirst) ...[
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    child: SizedBox(
                      height: 6,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            color: AppColors.surfaceVariant,
                          ),
                          FractionallySizedBox(
                            widthFactor: percent.clamp(0.0, 1.0),
                            child: Container(
                              color:
                                  isSuccess
                                      ? AppColors.secondary
                                      : AppColors.borderSubtle.withValues(
                                        alpha: 0.8,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
