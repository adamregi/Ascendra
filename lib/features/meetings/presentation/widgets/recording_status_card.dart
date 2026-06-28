import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';

enum RecordingStatus { ready, processing, failed, expired, none }

class RecordingStatusCard extends StatelessWidget {
  final RecordingStatus status;
  final String? duration;
  final String? fileSize;
  final DateTime? createdDate;
  final VoidCallback? onViewRecording;

  const RecordingStatusCard({
    super.key,
    required this.status,
    this.duration,
    this.fileSize,
    this.createdDate,
    this.onViewRecording,
  });

  @override
  Widget build(BuildContext context) {
    if (status == RecordingStatus.none) {
      return const SizedBox.shrink();
    }

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
                'Recording Status',
                style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
              ),
              _buildStatusBadge(),
            ],
          ),
          if (status == RecordingStatus.ready) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                _buildInfoItem(Icons.timer_outlined, duration ?? '--:--'),
                const SizedBox(width: AppSpacing.lg),
                _buildInfoItem(Icons.sd_storage_outlined, fileSize ?? '-- MB'),
                const SizedBox(width: AppSpacing.lg),
                _buildInfoItem(Icons.calendar_today_outlined, 
                  createdDate != null ? '${createdDate!.day}/${createdDate!.month}/${createdDate!.year}' : '--/--/----'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onViewRecording,
                icon: const Icon(Icons.play_circle_outline),
                label: Text(
                  'VIEW RECORDING',
                  style: AppTypography.labelMd.copyWith(letterSpacing: 1.0),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.borderSubtle),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
          ] else if (status == RecordingStatus.processing) ...[
            const SizedBox(height: AppSpacing.md),
            const LinearProgressIndicator(color: AppColors.secondary),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your recording is being processed and will be available shortly.',
              style: AppTypography.body2.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.onSurfaceVariant),
        const SizedBox(width: AppSpacing.xs),
        Text(text, style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface)),
      ],
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case RecordingStatus.ready:
        bgColor = AppColors.secondaryContainer;
        textColor = AppColors.onSecondaryContainer;
        text = 'Ready';
        break;
      case RecordingStatus.processing:
        bgColor = AppColors.surfaceContainer;
        textColor = AppColors.onSurfaceVariant;
        text = 'Processing';
        break;
      case RecordingStatus.failed:
        bgColor = AppColors.errorContainer;
        textColor = AppColors.error;
        text = 'Failed';
        break;
      case RecordingStatus.expired:
        bgColor = AppColors.surfaceContainer;
        textColor = AppColors.onSurfaceVariant;
        text = 'Expired';
        break;
      case RecordingStatus.none:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTypography.labelSm.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
