import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Hanken Grotesk';

  static const TextStyle displayLg = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 48,
    fontWeight: FontWeight.w600,
    height: 56 / 48,
    letterSpacing: -0.02 * 48,
  );

  static const TextStyle displayLgMobile = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 44 / 36,
    letterSpacing: -0.01 * 36,
  );

  static const TextStyle headlineMd = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 40 / 32,
  );

  static const TextStyle headlineSm = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 32 / 24,
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 28 / 18,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  static const TextStyle labelMd = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    letterSpacing: 0.05 * 14,
  );

  static const TextStyle labelSm = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
  );

  // Legacy mappings
  static const TextStyle h1 = displayLgMobile;
  static const TextStyle h2 = headlineMd;
  static const TextStyle h3 = headlineSm;
  static const TextStyle subtitle1 = labelMd;
  static const TextStyle body1 = bodyMd;
  static const TextStyle body2 = labelMd; // Using labelMd for slightly smaller body
  static const TextStyle caption = labelSm;
}
