import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../domain/entities/meeting_status.dart';

class MeetingPermissions {
  final bool isLeader;
  final bool canEdit;
  final bool canShare;

  const MeetingPermissions({
    this.isLeader = false,
    this.canEdit = false,
    this.canShare = true,
  });
}

class MeetingActionBar extends StatelessWidget {
  final MeetingStatus status;
  final MeetingPermissions permissions;
  final VoidCallback? onShare;
  final VoidCallback? onEdit;
  final VoidCallback? onJoin;

  const MeetingActionBar({
    super.key,
    required this.status,
    required this.permissions,
    this.onShare,
    this.onEdit,
    this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the primary action button based on status and permissions
    String primaryLabel;
    bool isPrimaryEnabled = true;

    if (status == MeetingStatus.completed ||
        status == MeetingStatus.cancelled) {
      primaryLabel = 'Meeting Ended';
      isPrimaryEnabled = false;
    } else if (permissions.isLeader) {
      primaryLabel = 'Start Meeting';
    } else {
      primaryLabel = 'Join Meeting';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.9),
        border: const Border(top: BorderSide(color: AppColors.borderSubtle)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (permissions.canShare) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: onShare,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.onSurface,
                    side: const BorderSide(color: AppColors.borderSubtle),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                  child: Text(
                    'SHARE INVITE',
                    style: AppTypography.labelMd.copyWith(letterSpacing: 1.0),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],

            if (permissions.canEdit &&
                status != MeetingStatus.completed &&
                status != MeetingStatus.cancelled) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.onSurface,
                    side: const BorderSide(color: AppColors.borderSubtle),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                  child: Text(
                    'EDIT',
                    style: AppTypography.labelMd.copyWith(letterSpacing: 1.0),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],

            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: isPrimaryEnabled ? onJoin : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  disabledBackgroundColor: AppColors.borderSubtle,
                  disabledForegroundColor: AppColors.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  primaryLabel.toUpperCase(),
                  style: AppTypography.labelMd.copyWith(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
