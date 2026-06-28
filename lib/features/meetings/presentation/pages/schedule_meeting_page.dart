import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/schedule_meeting_provider.dart';

class ScheduleMeetingPage extends ConsumerWidget {
  const ScheduleMeetingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(scheduleMeetingNotifierProvider);
    final notifier = ref.read(scheduleMeetingNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface.withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'NEW MEETING',
          style: AppTypography.labelMd.copyWith(
            letterSpacing: 2.0,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.onSurfaceVariant,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              120, // space for sticky button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLivePreviewCard(draft),
                const SizedBox(height: AppSpacing.xxl),

                // Form Fields
                AppTextField(
                  label: 'Meeting Title',
                  hint: 'e.g. Weekly Team Training',
                  onSubmitted: (val) => notifier.updateTitle(val),
                  // Use onChanged to immediately reflect in live preview
                  // AppTextField might not expose onChanged easily, but let's assume standard behavior or wrap in Focus
                ),
                const SizedBox(height: AppSpacing.lg),

                // Date & Time Row
                Row(
                  children: [
                    Expanded(
                      child: _buildDateTimeSelector(
                        icon: Icons.calendar_month,
                        value: _formatDate(draft.scheduledAt),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: draft.scheduledAt ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (date != null) notifier.updateDate(date);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _buildDateTimeSelector(
                        icon: Icons.schedule,
                        value: _formatTime(draft.scheduledAt),
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                              draft.scheduledAt ?? DateTime.now(),
                            ),
                          );
                          if (time != null)
                            notifier.updateTime(time.hour, time.minute);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // Duration
                Text(
                  'Duration',
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Row(
                    children:
                        MeetingDuration.values.map((d) {
                          return Expanded(
                            child: _buildDurationButton(
                              d.label,
                              draft.duration == d,
                              () => notifier.updateDuration(d),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                AppTextField(
                  label: 'Agenda (Optional)',
                  hint: 'What will be discussed?',
                  // Using onSubmitted as placeholder
                ),
              ],
            ),
          ),

          // Sticky Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.9),
                border: const Border(
                  top: BorderSide(color: AppColors.surfaceContainer),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await notifier.submit();
                      if (context.mounted) {
                        context.pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    'SCHEDULE MEETING',
                    style: AppTypography.labelMd.copyWith(
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLivePreviewCard(ScheduleMeetingDraft draft) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceContainer),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Text(
                  'LIVE PREVIEW',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const Icon(Icons.preview, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            draft.title.isEmpty ? 'Untitled Meeting' : draft.title,
            style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.surfaceContainer),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                _formatDate(draft.scheduledAt),
                style: AppTypography.body2.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: CircleAvatar(
                  radius: 2,
                  backgroundColor: AppColors.borderSubtle,
                ),
              ),
              Icon(Icons.schedule, size: 16, color: AppColors.onSurfaceVariant),
              const SizedBox(width: AppSpacing.xs),
              Text(
                _formatTime(draft.scheduledAt),
                style: AppTypography.body2.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelector({
    required IconData icon,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.surfaceContainer),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.onSurfaceVariant, size: 20),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: AppTypography.body2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationButton(
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: isSelected ? Border.all(color: AppColors.borderSubtle) : null,
          boxShadow:
              isSelected
                  ? const [
                    BoxShadow(
                      color: Color(0x05000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTypography.body2.copyWith(
            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime? date) {
    if (date == null) return 'Select Time';
    final hour =
        date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${date.minute.toString().padLeft(2, '0')} $period';
  }
}
