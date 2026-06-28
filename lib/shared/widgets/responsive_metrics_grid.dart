import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_typography.dart';

/// A single metric card definition to be passed into [ResponsiveMetricsGrid].
class MetricCardData {
  final Widget indicator;
  final String label;
  final String value;
  final String? suffix;

  const MetricCardData({
    required this.indicator,
    required this.label,
    required this.value,
    this.suffix,
  });
}

/// A responsive grid that displays metric cards.
/// Adapts to mobile (2 columns) and tablet/desktop (4 columns).
class ResponsiveMetricsGrid extends StatelessWidget {
  final List<MetricCardData> metrics;
  final double spacing;

  const ResponsiveMetricsGrid({
    super.key,
    required this.metrics,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile (≤414px) -> 2 columns
        // Tablet/Desktop (>414px) -> 4 columns
        final isMobile = constraints.maxWidth <= 414;

        // Use a Wrap or Grid? Wrap is flexible but we want equal heights.
        // Let's use IntrinsicHeight on the rows if we manually build them,
        // or just let them size naturally if they have the same content structure.
        // Since content is standardized, building Rows is safe.

        if (isMobile) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildCard(metrics[0])),
                  SizedBox(width: spacing),
                  Expanded(child: _buildCard(metrics[1])),
                ],
              ),
              SizedBox(height: spacing),
              Row(
                children: [
                  Expanded(child: _buildCard(metrics[2])),
                  SizedBox(width: spacing),
                  Expanded(child: _buildCard(metrics[3])),
                ],
              ),
            ],
          );
        } else {
          return Row(
            children: [
              Expanded(child: _buildCard(metrics[0])),
              SizedBox(width: spacing),
              Expanded(child: _buildCard(metrics[1])),
              SizedBox(width: spacing),
              Expanded(child: _buildCard(metrics[2])),
              SizedBox(width: spacing),
              Expanded(child: _buildCard(metrics[3])),
            ],
          );
        }
      },
    );
  }

  Widget _buildCard(MetricCardData data) {
    return Container(
      padding: const EdgeInsets.all(20), // 20dp internal padding as requested
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.borderSubtle.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              data.indicator,
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  data.label,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  data.value,
                  style: const TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
                if (data.suffix != null) ...[
                  const SizedBox(width: 2),
                  Text(
                    data.suffix!,
                    style: const TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
