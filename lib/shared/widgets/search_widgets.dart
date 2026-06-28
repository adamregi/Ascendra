import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;

  const SearchBarWidget({
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon:
            onClear != null
                ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: onClear,
                )
                : null,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      ),
    );
  }
}

class FilterChipGroup<T> extends StatelessWidget {
  final List<T> options;
  final T? selectedValue;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onSelected;

  const FilterChipGroup({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: const Text('All'),
              selected: selectedValue == null,
              onSelected: (selected) {
                if (selected) onSelected(null);
              },
              backgroundColor: Colors.transparent,
              selectedColor: AppColors.primary.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.full),
                side: BorderSide(
                  color:
                      selectedValue == null
                          ? AppColors.primary
                          : Theme.of(context).dividerColor,
                ),
              ),
            ),
          ),
          // Option chips
          ...options.map((option) {
            final isSelected = selectedValue == option;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: FilterChip(
                label: Text(labelBuilder(option)),
                selected: isSelected,
                onSelected: (selected) {
                  onSelected(selected ? option : null);
                },
                backgroundColor: Colors.transparent,
                selectedColor: AppColors.primary.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  side: BorderSide(
                    color:
                        isSelected
                            ? AppColors.primary
                            : Theme.of(context).dividerColor,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
