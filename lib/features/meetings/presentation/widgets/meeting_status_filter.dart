import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/meeting_status_filter.dart';

/// Segmented pill filter for meeting statuses.
///
/// Driven by the [MeetingStatusFilter] enum — adding a new value
/// automatically adds a new pill without modifying widget code.
class MeetingStatusFilterBar extends StatelessWidget {
  final MeetingStatusFilter selected;
  final ValueChanged<MeetingStatusFilter> onSelected;

  const MeetingStatusFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: AppColors.borderSubtle.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: MeetingStatusFilter.values.map((filter) {
            final isSelected = filter == selected;
            return Semantics(
              label: '${filter.label} meetings filter',
              selected: isSelected,
              child: GestureDetector(
                onTap: () => onSelected(filter),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.surfaceContainerLowest : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    filter.label,
                    style: AppTypography.labelMd.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
