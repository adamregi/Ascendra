import 'package:flutter/material.dart';

class AppColors {
  // Existing colors (kept for compatibility if used elsewhere)
  static const primaryOld = Color(0xFF6366F1);
  static const primaryDarkOld = Color(0xFF4F46E5);
  static const primaryLightOld = Color(0xFFEEEDFE);
  
  // Serene Modernist Brand Colors
  static const primary = Color(0xFF181e1a);
  static const secondary = Color(0xFF536257);
  static const tertiary = Color(0xFF241a1b);
  
  static const accentWarm = Color(0xFFD4AF37);
  static const success = Color(0xFF536257); // Reusing secondary for healthy status
  static const warning = Color(0xFFD4AF37); // Reusing accentWarm
  static const error = Color(0xFFba1a1a);
  
  // Surfaces
  static const background = Color(0xFFfcf9f7);
  static const surface = Color(0xFFffffff);
  static const surfaceContainerLowest = Color(0xFFffffff);
  static const surfaceContainerLow = Color(0xFFf6f3f1);
  static const surfaceContainer = Color(0xFFf0edec);
  static const surfaceVariant = Color(0xFFe5e2e0);
  
  // Containers
  static const errorContainer = Color(0xFFffdad6);
  static const secondaryContainer = Color(0xFFd6e7d9);
  
  // Typography & Elements
  static const onSurface = Color(0xFF1c1c1b);
  static const onSurfaceVariant = Color(0xFF444844);
  static const onBackground = Color(0xFF1c1c1b);
  static const onPrimary = Color(0xFFffffff);
  static const onSecondaryContainer = Color(0xFF59685d);
  static const borderSubtle = Color(0xFFE5E5E0);
  
  // Legacy aliases for compatibility
  static const textPrimary = Color(0xFF1c1c1b);
  static const textSecondary = Color(0xFF444844);
  static const textHint = Color(0xFF9CA3AF);
  static const leaderColor = Color(0xFF536257);
  static const memberColor = Color(0xFFD4AF37);
}
