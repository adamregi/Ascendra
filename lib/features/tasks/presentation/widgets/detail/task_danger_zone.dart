import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_radius.dart';

class TaskDangerZone extends StatelessWidget {
  const TaskDangerZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.xl),
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Column(
        children: [
          _buildAction(
            icon: LucideIcons.pauseCircle,
            label: 'Pause Task',
            color: AppColors.error,
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.xs),
          _buildAction(
            icon: LucideIcons.copy,
            label: 'Duplicate Task',
            color: AppColors.onSurface,
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.xs),
          _buildAction(
            icon: LucideIcons.archive,
            label: 'Archive Task',
            color: AppColors.error,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            Icon(icon, size: 20, color: color),
          ],
        ),
      ),
    );
  }
}
