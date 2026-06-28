import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ScoreRing extends StatelessWidget {
  final double score; // 0 to 100
  final double size;
  final double strokeWidth;
  final Widget? centerWidget;

  const ScoreRing({
    super.key,
    required this.score,
    this.size = 64.0,
    this.strokeWidth = 6.0,
    this.centerWidget,
  });

  Color _getColor() {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).dividerColor.withOpacity(0.1),
            ),
          ),
          CircularProgressIndicator(
            value: score / 100.0,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(_getColor()),
            backgroundColor: Colors.transparent,
          ),
          if (centerWidget != null) Center(child: centerWidget!),
        ],
      ),
    );
  }
}
