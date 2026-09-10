import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_palette.dart';

/// ColorScheme builder shared by light/dark themes.
ColorScheme buildAppColorScheme(Brightness brightness, AppPalette palette) {
  return ColorScheme(
    brightness: brightness,
    primary: brightness == Brightness.dark
        ? AppColors.primaryLight
        : AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    tertiary: AppColors.accent,
    onTertiary:
        brightness == Brightness.light ? Colors.white : Colors.black,
    error: AppColors.emergency,
    onError: Colors.white,
    surface: palette.surface,
    onSurface: palette.textPrimary,
    surfaceContainerHighest: palette.surfaceAlt,
    onSurfaceVariant: palette.textSecondary,
    outline: palette.border,
  );
}
