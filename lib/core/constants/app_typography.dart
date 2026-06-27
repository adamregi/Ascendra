import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Inter'; // Default font family

  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // Serene Modernist Typography
  static const TextStyle displayLgMobile = TextStyle(
    fontFamily: 'Newsreader',
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 44 / 36,
    letterSpacing: -0.01 * 36,
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
}
