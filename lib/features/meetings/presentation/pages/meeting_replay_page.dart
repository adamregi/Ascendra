import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../../domain/entities/attendance_status.dart';
import '../providers/meeting_replay_provider.dart';

class MeetingReplayPage extends ConsumerStatefulWidget {
  final String meetingId;

  const MeetingReplayPage({super.key, required this.meetingId});

  @override
  ConsumerState<MeetingReplayPage> createState() => _MeetingReplayPageState();
}

class _MeetingReplayPageState extends ConsumerState<MeetingReplayPage> {
  VideoPlayerController? _videoController;
  bool _isPlayerInitialized = false;
  bool _showControls = true;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  void _initVideo() async {
    // Retrieve replay data first to get the recording URL
    final replayData = await ref.read(meetingReplayProvider(widget.meetingId).future);
    final recordingUrl = replayData.meeting.recordingUrl;

    if (recordingUrl != null && recordingUrl.isNotEmpty) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(recordingUrl))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isPlayerInitialized = true;
              _totalDuration = _videoController!.value.duration;
            });
          }
        });

      _videoController!.addListener(_onVideoUpdate);
    }
  }

  void _onVideoUpdate() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      setState(() {
        _currentPosition = _videoController!.value.position;
      });
    }
  }

  @override
  void dispose() {
    _videoController?.removeListener(_onVideoUpdate);
    _videoController?.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _togglePlayPause() {
    if (_videoController == null) return;
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final replayAsync = ref.watch(meetingReplayProvider(widget.meetingId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: replayAsync.when(
          data: (data) => Text(
            data.meeting.title,
            style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
          ),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Error'),
        ),
        centerTitle: true,
      ),
      body: replayAsync.when(
        data: (data) => Column(
          children: [
            // 1. Video Player View (Hero aspect video ratio)
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildVideoHero(data.meeting.title),
                  
                  // 2. Info details section
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.meeting.title,
                                style: AppTypography.headlineSm.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 14, color: AppColors.onSurfaceVariant),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat('MMM dd, yyyy').format(data.meeting.scheduledAt),
                                    style: AppTypography.body2.copyWith(color: AppColors.onSurfaceVariant),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  const Icon(Icons.schedule, size: 14, color: AppColors.onSurfaceVariant),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${data.meeting.durationMinutes ?? 0}m',
                                    style: AppTypography.body2.copyWith(color: AppColors.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share, color: AppColors.primary),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Meeting replay link copied to clipboard!')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: AppColors.borderSubtle, height: 1),

                  // 3. Attendance report list
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: _buildAttendanceReport(data.attendances),
                  ),
                ],
              ),
            ),

            // 4. Footer Export Action Button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderSubtle, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      foregroundColor: AppColors.primary,
                    ),
                    icon: const Icon(Icons.download, size: 20),
                    label: const Text('EXPORT REPORT'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Attendance report exported successfully!')),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, _) => Center(child: Text('Error loading replay: $err')),
      ),
    );
  }

  Widget _buildVideoHero(String title) {
    final bool isPlaying = _videoController?.value.isPlaying ?? false;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Raw video surface or placeholder
            if (_isPlayerInitialized && _videoController != null)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showControls = !_showControls;
                  });
                },
                child: VideoPlayer(_videoController!),
              )
            else
              Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: Colors.white),
              ),

            // 2. Play/Pause Glassmorphic Overlay
            if (!_isPlayerInitialized || !_videoController!.value.isPlaying || _showControls)
              Center(
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                    ),
                  ),
                ),
              ),

            // 3. Bottom controls bar
            if (_isPlayerInitialized && _showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                      Expanded(
                        child: VideoProgressIndicator(
                          _videoController!,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Colors.white,
                            bufferedColor: Colors.white24,
                            backgroundColor: Colors.white10,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        '${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton(
                        icon: const Icon(Icons.fullscreen, color: Colors.white, size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceReport(List<AttendanceWithProfile> attendances) {
    final compliantCount = attendances.where((a) => a.attendance.attendanceStatus == AttendanceStatus.attended).length;
    final totalCount = attendances.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendance Report',
              style: AppTypography.headlineSm.copyWith(color: AppColors.primary),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.secondaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                '$compliantCount/$totalCount compliant',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: attendances.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final attendee = attendances[index];
            return _buildAttendeeRow(attendee);
          },
        ),
      ],
    );
  }

  Widget _buildAttendeeRow(AttendanceWithProfile item) {
    final status = item.attendance.attendanceStatus;
    final initials = item.fullName.trim().isNotEmpty
        ? item.fullName.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase()
        : '?';

    // Status mapping widgets
    Widget statusBadge;
    Color rowBorderColor = AppColors.borderSubtle;

    switch (status) {
      case AttendanceStatus.attended:
        statusBadge = Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFecfdf5),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check, size: 12, color: Color(0xFF059669)),
              SizedBox(width: 2),
              Text(
                'Compliant',
                style: TextStyle(
                  color: Color(0xFF059669),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
        break;
      case AttendanceStatus.partial:
        statusBadge = Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFfef3c7),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.schedule, size: 12, color: Color(0xFFd97706)),
              SizedBox(width: 2),
              Text(
                'Partial',
                style: TextStyle(
                  color: Color(0xFFd97706),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
        break;
      default: // absent/excused/registered -> Missed
        rowBorderColor = AppColors.errorContainer;
        statusBadge = Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.errorContainer,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close, size: 12, color: AppColors.error),
              SizedBox(width: 2),
              Text(
                'Missed',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
    }

    // Time text calculation
    String durationText = 'Did not join';
    if (item.attendance.firstJoinedAt != null) {
      final joinedTime = DateFormat('hh:mm a').format(item.attendance.firstJoinedAt!.toLocal());
      durationText = 'Joined $joinedTime • ${item.attendance.totalDurationMinutes}m';
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: rowBorderColor),
      ),
      child: Row(
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
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.fullName,
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  durationText,
                  style: AppTypography.body2.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          statusBadge,
        ],
      ),
    );
  }
}
