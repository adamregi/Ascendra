import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class TrendChip extends StatelessWidget {
  final double trendValue; // positive or negative
  final String label;

  const TrendChip({super.key, required this.trendValue, required this.label});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = trendValue >= 0;
    final Color color = isPositive ? AppColors.success : AppColors.error;
    final IconData icon =
        isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            '${trendValue.abs().toStringAsFixed(1)}% $label',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
