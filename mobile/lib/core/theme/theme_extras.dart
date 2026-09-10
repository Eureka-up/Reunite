import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_palette.dart';

/// Remaining component themes: bars, sheets, indicators, selection.
SnackBarThemeData buildSnackBarTheme(TextTheme textTheme, bool isDark) {
  return SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor:
        isDark ? AppColors.surfaceAltDark : AppColors.textPrimaryLight,
    contentTextStyle: textTheme.bodyMedium?.copyWith(
      color: isDark ? AppColors.textPrimaryDark : Colors.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
    ),
  );
}

BottomSheetThemeData buildBottomSheetTheme(AppPalette palette) {
  return BottomSheetThemeData(
    backgroundColor: palette.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radiusXl),
      ),
    ),
    showDragHandle: true,
  );
}

AppBarTheme buildAppBarTheme(TextTheme textTheme, AppPalette palette) {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    foregroundColor: palette.textPrimary,
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: palette.textPrimary,
      fontWeight: FontWeight.w700,
    ),
    iconTheme: IconThemeData(color: palette.textPrimary),
  );
}

ProgressIndicatorThemeData buildProgressTheme(AppPalette palette) {
  return ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: palette.surfaceAlt,
  );
}

TextSelectionThemeData buildSelectionTheme() {
  return TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionColor: AppColors.primary.withValues(alpha: 0.25),
    selectionHandleColor: AppColors.primary,
  );
}
