import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';

class ParticipantTile extends StatelessWidget {
  final HMSPeer peer;
  final bool isSpeaking;

  const ParticipantTile({
    super.key,
    required this.peer,
    this.isSpeaking = false,
  });

  @override
  Widget build(BuildContext context) {
    final videoTrack = peer.videoTrack;
    final isVideoMuted = videoTrack?.isMute ?? true;
    final isMicMuted = peer.audioTrack?.isMute ?? true;
    final isHost = peer.role.name.toLowerCase() == 'host';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: isSpeaking 
              ? AppColors.primary 
              : (isHost ? AppColors.secondary.withValues(alpha: 0.3) : Colors.transparent),
          width: isSpeaking ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 1. Video View or Avatar Placeholder
          Positioned.fill(
            child: (videoTrack != null && !isVideoMuted)
                ? HMSVideoView(
                    track: videoTrack,
                    scaleType: ScaleType.SCALE_ASPECT_FILL,
                  )
                : _buildAvatarPlaceholder(),
          ),

          // 2. Gradient Overlay for metadata legibility
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.25, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // 3. Name & Host Badge overlay (Bottom Left)
          Positioned(
            bottom: AppSpacing.sm,
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    peer.name,
                    style: AppTypography.body2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isHost)
                  Container(
                    margin: const EdgeInsets.only(left: AppSpacing.xs),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      'HOST',
                      style: AppTypography.labelSm.copyWith(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // 4. Mic Status Indicator (Top Right)
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isMicMuted 
                    ? AppColors.error.withValues(alpha: 0.9) 
                    : Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isMicMuted ? Icons.mic_off : Icons.mic,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),

          // 5. Speaking Border Highlight Indicator (Top Left)
          if (isSpeaking)
            Positioned(
              top: AppSpacing.sm,
              left: AppSpacing.sm,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.volume_up, size: 10, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      'SPEAKING',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    final initials = peer.name.trim().isNotEmpty
        ? peer.name.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase()
        : '?';

    return Container(
      color: AppColors.surfaceContainerLow,
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: 36,
        backgroundColor: AppColors.surfaceVariant,
        child: Text(
          initials,
          style: AppTypography.headlineSm.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
