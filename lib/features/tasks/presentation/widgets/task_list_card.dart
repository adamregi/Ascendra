import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../shared/widgets/badges.dart';
import '../../domain/entities/task.dart';

/// Individual task card shown in the task list.
/// Matches the task row design in tasks_command_center_leader reference.
class TaskListCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskListCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isOverdue = _isOverdue;
    final accentColor = _accentColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: AppColors.borderSubtle.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            // Status accent bar
            Container(
              width: 3,
              height: 48,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: const TextStyle(
                            fontFamily: 'Newsreader',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _buildStatusBadge(),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Assignee
                      Icon(
                        LucideIcons.user,
                        size: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          task.assignedTo.isNotEmpty
                              ? '${task.assignedTo.length} member${task.assignedTo.length > 1 ? 's' : ''}'
                              : 'Unassigned',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Due date
                      if (task.dueDate != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          _dueDateDisplay(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isOverdue ? FontWeight.w600 : FontWeight.w400,
                            color:
                                isOverdue
                                    ? AppColors.error
                                    : AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                  // Priority + Tags row
                  if (task.priority != 'low' || task.tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (task.priority == 'high' ||
                            task.priority == 'urgent')
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: PriorityBadge(priority: task.priority),
                          ),
                        ...task.tags
                            .take(2)
                            .map(
                              (tag) => Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.full,
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Chevron
            const Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    switch (task.status) {
      case 'completed':
        return const StatusBadge(label: 'Completed', color: Color(0xFF10b981));
      case 'in_progress':
      case 'active':
        return const StatusBadge(label: 'Active', color: Color(0xFF4f46e5));
      case 'draft':
      case 'assigned':
      case 'open':
        return const StatusBadge(label: 'Open', color: Color(0xFF64748b));
      default:
        return const SizedBox.shrink();
    }
  }

  bool get _isOverdue {
    if (task.dueDate == null) return false;
    return task.status != 'completed' &&
        task.status != 'cancelled' &&
        DateTime.now().isAfter(task.dueDate!);
  }

  Color get _accentColor {
    if (_isOverdue) return AppColors.error;
    switch (task.status) {
      case 'completed':
        return const Color(0xFF10b981);
      case 'in_progress':
      case 'active':
        return const Color(0xFF4f46e5);
      default:
        return AppColors.onSurfaceVariant;
    }
  }

  String _dueDateDisplay() {
    if (task.dueDate == null) return '';
    final now = DateTime.now();
    final diff = task.dueDate!.difference(now);

    if (diff.isNegative) {
      final days = diff.inDays.abs();
      if (days == 0) return 'Due Today';
      if (days == 1) return 'Due Yesterday';
      return '$days Days Late';
    } else {
      final days = diff.inDays;
      if (days == 0) return 'Due Today';
      if (days == 1) return 'Due Tomorrow';
      return 'Due in $days days';
    }
  }
}
