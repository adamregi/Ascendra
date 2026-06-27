import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import 'responsive_builder.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  
  const ResponsiveGrid({
    super.key, 
    required this.children,
    this.spacing = AppSpacing.md,
    this.runSpacing = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildSpacedChildren(children, runSpacing, isVertical: true),
      ),
      tablet: (context, constraints) => Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children.map((c) => SizedBox(
          width: (constraints.maxWidth - spacing) / 2,
          child: c,
        )).toList(),
      ),
      desktop: (context, constraints) => Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children.map((c) => SizedBox(
          width: (constraints.maxWidth - (spacing * 2)) / 3, // 3 columns
          child: c,
        )).toList(),
      ),
    );
  }

  List<Widget> _buildSpacedChildren(List<Widget> children, double spacing, {required bool isVertical}) {
    if (children.isEmpty) return [];
    final spaced = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i < children.length - 1) {
        spaced.add(SizedBox(
          height: isVertical ? spacing : 0,
          width: isVertical ? 0 : spacing,
        ));
      }
    }
    return spaced;
  }
}
