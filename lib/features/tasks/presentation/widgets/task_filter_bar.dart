import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../providers/tasks_providers.dart';

/// Horizontal filter chip bar for the Tasks dashboard.
class TaskFilterBar extends StatelessWidget {
  final TaskDashboardFilter selected;
  final ValueChanged<TaskDashboardFilter> onSelected;

  const TaskFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            TaskDashboardFilter.values.map((filter) {
              final isActive = filter == selected;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_label(filter)),
                  selected: isActive,
                  onSelected: (_) => onSelected(filter),
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surfaceContainerLow,
                  labelStyle: TextStyle(
                    fontFamily: 'Hanken Grotesk',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color:
                        isActive
                            ? AppColors.onPrimary
                            : AppColors.onSurfaceVariant,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    side: BorderSide(
                      color:
                          isActive ? AppColors.primary : AppColors.borderSubtle,
                    ),
                  ),
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  String _label(TaskDashboardFilter filter) {
    switch (filter) {
      case TaskDashboardFilter.all:
        return 'All';
      case TaskDashboardFilter.open:
        return 'Open';
      case TaskDashboardFilter.inProgress:
        return 'In Progress';
      case TaskDashboardFilter.completed:
        return 'Completed';
      case TaskDashboardFilter.overdue:
        return 'Overdue';
    }
  }
}
