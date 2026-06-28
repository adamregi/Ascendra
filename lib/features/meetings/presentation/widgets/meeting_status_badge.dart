import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/badges.dart';
import '../../domain/entities/meeting_status.dart';

/// Resolves a [MeetingStatus] to its semantic badge appearance.
///
/// Keeps the badge widget independent of the color palette —
/// all mappings are centralized here.
class MeetingStatusBadgeTheme {
  final String label;
  final Color color;

  const MeetingStatusBadgeTheme({required this.label, required this.color});

  static const _teal = Color(0xFF14B8A6);
  static const _emerald = Color(0xFF10B981);

  factory MeetingStatusBadgeTheme.fromStatus(MeetingStatus status) {
    switch (status) {
      case MeetingStatus.live:
        return const MeetingStatusBadgeTheme(label: 'Live', color: _teal);
      case MeetingStatus.scheduled:
        return MeetingStatusBadgeTheme(label: 'Scheduled', color: AppColors.secondary);
      case MeetingStatus.completed:
        return const MeetingStatusBadgeTheme(label: 'Completed', color: _emerald);
      case MeetingStatus.cancelled:
        return MeetingStatusBadgeTheme(label: 'Cancelled', color: AppColors.error);
    }
  }
}

/// A meeting-aware status badge that resolves colors from a central theme.
class MeetingStatusBadge extends StatelessWidget {
  final MeetingStatus status;

  const MeetingStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = MeetingStatusBadgeTheme.fromStatus(status);
    return StatusBadge(label: theme.label, color: theme.color);
  }
}

/// Pulsing live indicator dot used in live meeting cards and snapshot.
class LivePulseIndicator extends StatefulWidget {
  final double size;

  const LivePulseIndicator({super.key, this.size = 8});

  @override
  State<LivePulseIndicator> createState() => _LivePulseIndicatorState();
}

class _LivePulseIndicatorState extends State<LivePulseIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  static const _teal = Color(0xFF14B8A6);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _teal,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _teal.withValues(alpha: 0.4 * (1 - _animation.value / 6)),
                blurRadius: _animation.value,
                spreadRadius: _animation.value / 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
