import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';

class MeetingParticipantsSection extends StatelessWidget {
  final int totalInvites;
  final int confirmed;

  const MeetingParticipantsSection({
    super.key,
    required this.totalInvites,
    required this.confirmed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildReadinessChecklist(),
        const SizedBox(height: AppSpacing.lg),
        _buildGuestList(),
      ],
    );
  }

  Widget _buildReadinessChecklist() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Readiness Checklist',
            style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildChecklistItem('Invites Sent', Icons.check_circle, AppColors.secondary),
          const SizedBox(height: AppSpacing.sm),
          _buildChecklistItem('Reminder Scheduled', Icons.check_circle, AppColors.secondary),
          const SizedBox(height: AppSpacing.sm),
          _buildChecklistItem('Recording Enabled', Icons.warning_rounded, AppColors.warning),
          
          if (totalInvites - confirmed > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.errorContainer,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${totalInvites - confirmed} Members Yet to Confirm',
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.error, color: AppColors.error, size: 20),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String label, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface)),
          Icon(icon, color: iconColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildGuestList() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Guest List',
                style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'VIEW ALL',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.secondary,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Segmented Control (Mock for UI)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                Expanded(child: _buildSegmentButton('Attending', true)),
                Expanded(child: _buildSegmentButton('Maybe', false)),
                Expanded(child: _buildSegmentButton('Pending', false)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Avatar Stack
          Row(
            children: [
              SizedBox(
                width: 100, // Fixed width for overlapping avatars
                height: 40,
                child: Stack(
                  children: [
                    Positioned(left: 0, child: _buildAvatar(0)),
                    Positioned(left: 20, child: _buildAvatar(1)),
                    Positioned(left: 40, child: _buildAvatar(2)),
                    Positioned(left: 60, child: _buildAvatar(3)),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  '+ $confirmed others confirmed',
                  style: AppTypography.body2.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.surface : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        boxShadow: isSelected
            ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 2, offset: Offset(0, 1))]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        label.toUpperCase(),
        style: AppTypography.labelSm.copyWith(
          color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildAvatar(int index) {
    // Placeholder logic for UI matching
    const colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple];
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors[index % colors.length].shade200,
        border: Border.all(color: AppColors.surfaceContainerLowest, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        String.fromCharCode(65 + index), // A, B, C...
        style: AppTypography.labelSm,
      ),
    );
  }
}
