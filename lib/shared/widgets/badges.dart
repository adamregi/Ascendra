import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({
    super.key,
    required this.label,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class RiskBadge extends StatelessWidget {
  final String riskLevel; // 'critical', 'high', 'medium', 'low'

  const RiskBadge({super.key, required this.riskLevel});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (riskLevel.toLowerCase()) {
      case 'critical':
        color = AppColors.error;
        break;
      case 'high':
        color = AppColors.warning;
        break;
      case 'medium':
        color = AppColors.warning.withValues(alpha: 0.7);
        break;
      case 'low':
      default:
        color = AppColors.success;
    }

    return StatusBadge(label: riskLevel, color: color);
  }
}

class MetricChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;

  const MetricChip({
    super.key,
    required this.label,
    this.icon,
    this.color = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark 
            ? const Color(0xFF374151) 
            : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
