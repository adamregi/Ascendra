import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../profile/providers/profile_provider.dart';
import '../providers/live_meeting_provider.dart';
import '../widgets/video_grid.dart';
import '../widgets/meeting_controls.dart';

class LiveMeetingPage extends ConsumerStatefulWidget {
  final String meetingId;

  const LiveMeetingPage({super.key, required this.meetingId});

  @override
  ConsumerState<LiveMeetingPage> createState() => _LiveMeetingPageState();
}

class _LiveMeetingPageState extends ConsumerState<LiveMeetingPage> {
  Timer? _meetingTimer;
  int _secondsElapsed = 0;
  bool _permissionError = false;
  bool _isTimerStarted = false;

  @override
  void initState() {
    super.initState();
    _requestPermissionsAndJoin();
  }

  @override
  void dispose() {
    _meetingTimer?.cancel();
    super.dispose();
  }

  Future<void> _requestPermissionsAndJoin() async {
    final cameraStatus = await Permission.camera.request();
    final micStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && micStatus.isGranted) {
      final profile = await ref.read(profileProvider.future);
      final userName = profile?.fullName ?? 'Ascendra Member';
      
      if (mounted) {
        await ref.read(liveMeetingControllerProvider.notifier).joinMeeting(widget.meetingId, userName);
      }
    } else {
      if (mounted) {
        setState(() {
          _permissionError = true;
        });
      }
    }
  }

  void _startTimer() {
    if (_isTimerStarted) return;
    _isTimerStarted = true;
    _meetingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  String _formatDuration(int seconds) {
    final hrs = seconds ~/ 3600;
    final mins = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hrs.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(liveMeetingControllerProvider);
    final controller = ref.read(liveMeetingControllerProvider.notifier);

    // Auto-pop or handle transition on disconnect
    ref.listen(liveMeetingControllerProvider.select((s) => s.status), (prev, next) {
      if (next == LiveMeetingStatus.disconnected) {
        context.pop();
      }
    });

    if (_permissionError) {
      return _buildErrorState('Permissions Denied', 'Camera and microphone permissions are required to join video meetings.');
    }

    switch (state.status) {
      case LiveMeetingStatus.idle:
      case LiveMeetingStatus.joining:
        return _buildConnectingState();
      case LiveMeetingStatus.error:
        return _buildErrorState('Connection Failed', state.errorMessage ?? 'An unknown error occurred while joining.');
      case LiveMeetingStatus.disconnected:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case LiveMeetingStatus.connected:
      case LiveMeetingStatus.reconnecting:
        if (state.status == LiveMeetingStatus.connected) {
          _startTimer();
        }
        return Scaffold(
          backgroundColor: const Color(0xFF121412),
          body: SafeArea(
            child: Stack(
              children: [
                // 1. Base Video Grid
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: VideoGrid(
                      localPeer: state.localPeer,
                      remotePeers: state.remotePeers,
                    ),
                  ),
                ),

                // 2. Translucent Warning Overlay for Reconnecting
                if (state.status == LiveMeetingStatus.reconnecting)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: AppColors.error.withValues(alpha: 0.9),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        'Reconnecting... Please check your internet connection.',
                        style: AppTypography.body2.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                // 3. Top Controls (LIVE badge & timer + Participant count)
                Positioned(
                  top: AppSpacing.md,
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // LIVE Badge & Stopwatch
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatDuration(_secondsElapsed),
                              style: AppTypography.labelMd.copyWith(
                                color: Colors.white,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Participant count badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.group, size: 16, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text(
                              '${state.remotePeers.length + 1}',
                              style: AppTypography.labelMd.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 4. Overlaid Horizontal Participant tray (avatars scrolling strip)
                Positioned(
                  bottom: 110,
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  child: _buildParticipantTray(state),
                ),

                // 5. Floating Local Self Video PiP (bottom right above tray)
                if (state.localPeer != null && !state.isCameraMuted)
                  Positioned(
                    bottom: 190,
                    right: AppSpacing.md,
                    child: Container(
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: Colors.white30, width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: HMSVideoView(
                        track: state.localPeer!.videoTrack!,
                        scaleType: ScaleType.SCALE_ASPECT_FILL,
                      ),
                    ),
                  ),

                // 6. Floating Control Bar
                Positioned(
                  bottom: AppSpacing.lg,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: MeetingControls(
                      isMicMuted: state.isMicMuted,
                      isCameraMuted: state.isCameraMuted,
                      isSpeakerPhoneOn: state.isSpeakerPhoneOn,
                      onToggleMic: controller.toggleMic,
                      onToggleCamera: controller.toggleCamera,
                      onToggleSpeaker: controller.toggleSpeakerPhone,
                      onLeave: controller.leaveMeeting,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildConnectingState() {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Connecting to Room...',
              style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Configuring hardware & media streams',
              style: AppTypography.body2.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String title, String subtitle) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: AppSpacing.xl),
              Text(title, style: AppTypography.headlineSm),
              const SizedBox(height: AppSpacing.md),
              Text(
                subtitle,
                style: AppTypography.body2.copyWith(color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                onPressed: () => context.pop(),
                child: const Text('Back to Meeting Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantTray(LiveMeetingState state) {
    final allPeers = [
      if (state.localPeer != null) state.localPeer!,
      ...state.remotePeers,
    ];

    if (allPeers.length <= 1) return const SizedBox.shrink();

    return SizedBox(
      height: 64,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allPeers.length,
        itemBuilder: (context, index) {
          final peer = allPeers[index];
          final isMuted = peer.audioTrack?.isMute ?? true;
          final initials = peer.name.trim().isNotEmpty
              ? peer.name.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase()
              : '?';

          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.surfaceVariant,
                      child: Text(
                        initials,
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isMuted)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.mic_off, size: 8, color: Colors.white),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  peer.name.split(' ')[0],
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
