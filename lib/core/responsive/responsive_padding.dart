import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import 'responsive_builder.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;

  const ResponsivePadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile:
          (context, constraints) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: child,
          ),
      tablet:
          (context, constraints) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.1, // 10% margins
            ),
            child: child,
          ),
      desktop:
          (context, constraints) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ), // Max width container
              child: child,
            ),
          ),
    );
  }
}
