import 'package:flutter/widgets.dart';

/// Spacing, radii, shadows and control sizes for the design system.
class AppDimens {
  const AppDimens._();

  // Spacing scale
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double giant = 56;

  // Radius
  static const double radiusSm = 10;
  static const double radiusMd = 16;
  static const double radiusLg = 22;
  static const double radiusXl = 28;
  static const double radiusPill = 100;

  // Controls
  static const double buttonHeight = 52;
  static const double inputHeight = 54;
  static const double minTouchTarget = 48;
  static const double iconButtonSize = 44;
  static const double avatarSize = 40;

  /// Light responsive scale for tablets.
  static double responsive(BuildContext context, double size) {
    final double width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return size * 1.12;
    if (width >= 600) return size * 1.05;
    return size;
  }

  /// True on tablets / large screens.
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 700;
}