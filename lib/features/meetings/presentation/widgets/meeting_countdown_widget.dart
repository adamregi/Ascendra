import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';

class MeetingCountdownWidget extends StatefulWidget {
  final DateTime startTime;

  const MeetingCountdownWidget({super.key, required this.startTime});

  @override
  State<MeetingCountdownWidget> createState() => _MeetingCountdownWidgetState();
}

class _MeetingCountdownWidgetState extends State<MeetingCountdownWidget> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _calculateRemaining());
  }

  void _calculateRemaining() {
    final now = DateTime.now();
    final remaining = widget.startTime.difference(now);
    setState(() {
      _remaining = remaining.isNegative ? Duration.zero : remaining;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining == Duration.zero) {
      return const SizedBox.shrink(); // Could show "Started" state instead
    }

    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeSegment(days.toString().padLeft(2, '0'), 'Days'),
        _buildSeparator(),
        _buildTimeSegment(hours.toString().padLeft(2, '0'), 'Hours'),
        _buildSeparator(),
        _buildTimeSegment(minutes.toString().padLeft(2, '0'), 'Mins'),
        _buildSeparator(),
        _buildTimeSegment(
          seconds.toString().padLeft(2, '0'), 
          'Secs',
          valueColor: AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildTimeSegment(String value, String label, {Color valueColor = AppColors.primary}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTypography.displayLgMobile.copyWith(
            color: valueColor,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label.toUpperCase(),
          style: AppTypography.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Text(
        ':',
        style: AppTypography.displayLgMobile.copyWith(
          color: AppColors.borderSubtle,
        ),
      ),
    );
  }
}
