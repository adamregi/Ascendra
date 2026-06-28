import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../providers/tasks_providers.dart';

/// Empty state displayed when no tasks match the current filter.
class TaskEmptyState extends StatelessWidget {
  final TaskDashboardFilter filter;

  const TaskEmptyState({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(_icon, size: 32, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _title,
              style: const TextStyle(
                fontFamily: 'Newsreader',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    switch (filter) {
      case TaskDashboardFilter.overdue:
        return LucideIcons.checkCircle;
      case TaskDashboardFilter.completed:
        return LucideIcons.listTodo;
      default:
        return LucideIcons.clipboardList;
    }
  }

  String get _title {
    switch (filter) {
      case TaskDashboardFilter.all:
        return 'No tasks yet';
      case TaskDashboardFilter.open:
        return 'No open tasks';
      case TaskDashboardFilter.inProgress:
        return 'Nothing in progress';
      case TaskDashboardFilter.completed:
        return 'No completed tasks';
      case TaskDashboardFilter.overdue:
        return 'Nothing overdue';
    }
  }

  String get _subtitle {
    switch (filter) {
      case TaskDashboardFilter.overdue:
        return 'Your team is on track. No overdue tasks.';
      case TaskDashboardFilter.completed:
        return 'Tasks will appear here once completed.';
      default:
        return 'Create your first task to get started.';
    }
  }
}
