import 'package:flutter/material.dart';

/// Typography scale. Tajawal is Arabic-first and Latin friendly.
class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Tajawal';

  static TextTheme textTheme() {
    const String family = fontFamily;
    return const TextTheme(
      displayLarge: TextStyle(
          fontFamily: family, fontSize: 40, height: 1.15, fontWeight: FontWeight.w800),
      displayMedium: TextStyle(
          fontFamily: family, fontSize: 34, height: 1.2, fontWeight: FontWeight.w800),
      headlineLarge: TextStyle(
          fontFamily: family, fontSize: 28, height: 1.25, fontWeight: FontWeight.w800),
      headlineMedium: TextStyle(
          fontFamily: family, fontSize: 24, height: 1.3, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
          fontFamily: family, fontSize: 20, height: 1.35, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(
          fontFamily: family, fontSize: 18, height: 1.4, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(
          fontFamily: family, fontSize: 16, height: 1.4, fontWeight: FontWeight.w700),
      titleSmall: TextStyle(
          fontFamily: family, fontSize: 14, height: 1.45, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          fontFamily: family, fontSize: 16, height: 1.55, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          fontFamily: family, fontSize: 14, height: 1.55, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: family, fontSize: 12, height: 1.55, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(
          fontFamily: family, fontSize: 15, height: 1.2, fontWeight: FontWeight.w700),
      labelMedium: TextStyle(
          fontFamily: family, fontSize: 13, height: 1.2, fontWeight: FontWeight.w700),
      labelSmall: TextStyle(
          fontFamily: family, fontSize: 11, height: 1.2, fontWeight: FontWeight.w700),
    );
  }
}