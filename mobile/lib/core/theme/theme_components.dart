import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_palette.dart';

/// Component themes: inputs, switches, buttons, chips, bars, sheets.
InputDecorationTheme buildInputTheme(
  TextTheme textTheme,
  AppPalette palette,
  bool isDark,
) {
  OutlineInputBorder border(ColorSide side) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        borderSide: side == ColorSide.none
            ? BorderSide.none
            : BorderSide(
                color: side == ColorSide.primary
                    ? AppColors.primary
                    : AppColors.emergency,
                width: side == ColorSide.plain ? 1 : 1.5,
              ),
      );
  return InputDecorationTheme(
    filled: true,
    fillColor: palette.surfaceAlt.withValues(alpha: isDark ? 0.6 : 0.5),
    hintStyle: textTheme.bodyMedium?.copyWith(color: palette.textMuted),
    labelStyle: textTheme.bodyMedium?.copyWith(color: palette.textSecondary),
    errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.emergency),
    prefixIconColor: palette.textMuted,
    suffixIconColor: palette.textMuted,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppDimens.lg,
      vertical: 16,
    ),
    border: border(ColorSide.none),
    enabledBorder: border(ColorSide.none),
    focusedBorder: border(ColorSide.primary),
    errorBorder: border(ColorSide.error),
    focusedErrorBorder: border(ColorSide.error),
    disabledBorder: border(ColorSide.none),
  );
}

enum ColorSide { none, plain, primary, error }

SwitchThemeData buildSwitchTheme(AppPalette palette) {
  return SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.white;
      return palette.textMuted;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.primary;
      return palette.surfaceAlt;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.transparent;
      return palette.border;
    }),
  );
}

FilledButtonThemeData buildFilledButtonTheme(
  ColorScheme scheme,
  TextTheme textTheme,
) {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: scheme.primary,
      foregroundColor: Colors.white,
      textStyle: textTheme.labelLarge,
      minimumSize: const Size(64, AppDimens.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
    ),
  );
}

OutlinedButtonThemeData buildOutlinedButtonTheme(
  ColorScheme scheme,
  TextTheme textTheme,
  AppPalette palette,
) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: scheme.primary,
      textStyle: textTheme.labelLarge,
      side: BorderSide(color: palette.border),
      minimumSize: const Size(64, AppDimens.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
    ),
  );
}

ChipThemeData buildChipTheme(
  TextTheme textTheme,
  AppPalette palette,
  bool isDark,
) {
  return ChipThemeData(
    backgroundColor:
        isDark ? palette.surfaceAlt.withValues(alpha: 0.6) : palette.surfaceAlt,
    selectedColor: AppColors.primary,
    disabledColor: palette.surfaceAlt,
    labelStyle: textTheme.labelMedium?.copyWith(color: palette.textPrimary),
    secondaryLabelStyle:
        textTheme.labelMedium?.copyWith(color: Colors.white),
    side: BorderSide(color: palette.border),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppDimens.lg,
      vertical: AppDimens.sm,
    ),
    labelPadding: const EdgeInsets.symmetric(
      horizontal: AppDimens.sm,
      vertical: 2,
    ),
  );
}
