import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class MeetingControls extends StatelessWidget {
  final bool isMicMuted;
  final bool isCameraMuted;
  final bool isSpeakerPhoneOn;
  final VoidCallback onToggleMic;
  final VoidCallback onToggleCamera;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onLeave;

  const MeetingControls({
    super.key,
    required this.isMicMuted,
    required this.isCameraMuted,
    required this.isSpeakerPhoneOn,
    required this.onToggleMic,
    required this.onToggleCamera,
    required this.onToggleSpeaker,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.borderSubtle.withValues(alpha: 0.3),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. Mic Control
          _buildControlButton(
            icon: isMicMuted ? Icons.mic_off : Icons.mic,
            isActive: !isMicMuted,
            onPressed: onToggleMic,
            isDestructive: isMicMuted,
          ),
          const SizedBox(width: 12),

          // 2. Camera Control
          _buildControlButton(
            icon: isCameraMuted ? Icons.videocam_off : Icons.videocam,
            isActive: !isCameraMuted,
            onPressed: onToggleCamera,
            isDestructive: isCameraMuted,
          ),
          const SizedBox(width: 12),

          // 3. Speaker Control
          _buildControlButton(
            icon: isSpeakerPhoneOn ? Icons.volume_up : Icons.volume_down,
            isActive: isSpeakerPhoneOn,
            onPressed: onToggleSpeaker,
            isDestructive: false,
          ),
          const SizedBox(width: 16),

          // 4. Leave Call (Larger Red Button)
          GestureDetector(
            onTap: onLeave,
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onPressed,
    required bool isDestructive,
  }) {
    Color getBgColor() {
      if (isDestructive) {
        return AppColors.error.withValues(alpha: 0.1);
      }
      if (isActive) {
        return AppColors.primary.withValues(alpha: 0.05);
      }
      return Colors.transparent;
    }

    Color getIconColor() {
      if (isDestructive) {
        return AppColors.error;
      }
      return AppColors.onSurfaceVariant;
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: getBgColor(),
          shape: BoxShape.circle,
          border: Border.all(
            color: isDestructive 
                ? AppColors.error.withValues(alpha: 0.2) 
                : AppColors.borderSubtle.withValues(alpha: 0.3),
            width: 1.0,
          ),
        ),
        child: Icon(
          icon,
          color: getIconColor(),
          size: 24,
        ),
      ),
    );
  }
}
