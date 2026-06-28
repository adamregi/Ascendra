import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

class TimelineItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final IconData? icon;
  final bool isLast;
  final bool isCompleted;

  const TimelineItem({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.icon,
    this.isLast = false,
    this.isCompleted = true,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator column
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color:
                        isCompleted
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.surfaceContainerLow,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isCompleted
                              ? AppColors.primary
                              : AppColors.borderSubtle,
                      width: 2,
                    ),
                  ),
                  child:
                      icon != null
                          ? Icon(
                            icon,
                            size: 12,
                            color:
                                isCompleted
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                          )
                          : (isCompleted
                              ? const Icon(
                                Icons.check,
                                size: 12,
                                color: AppColors.primary,
                              )
                              : null),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color:
                          isCompleted
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : AppColors.borderSubtle,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Content column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isCompleted ? null : AppColors.textSecondary,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
