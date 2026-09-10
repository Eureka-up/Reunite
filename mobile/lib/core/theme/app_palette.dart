import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Light/dark palette exposed via [ThemeExtension].
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.emergencySoft,
    required this.successSoft,
    required this.infoSoft,
    required this.cardShadow,
    required this.brandGradient,
    required this.heroGradient,
    required this.emergencyGradient,
    required this.successGradient,
  });

  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color emergencySoft;
  final Color successSoft;
  final Color infoSoft;
  final Color cardShadow;
  final Gradient brandGradient;
  final Gradient heroGradient;
  final Gradient emergencyGradient;
  final Gradient successGradient;

  static AppPalette of(BuildContext context) =>
      Theme.of(context).extension<AppPalette>() ?? AppPalette.light;

  static const AppPalette light = AppPalette(
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    surfaceAlt: AppColors.surfaceAltLight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
    textMuted: AppColors.textMutedLight,
    border: AppColors.borderLight,
    emergencySoft: AppColors.emergencySoft,
    successSoft: AppColors.successSoft,
    infoSoft: AppColors.infoSoft,
    cardShadow: Color(0x0A212529),
    brandGradient: AppColors.brandGradient,
    heroGradient: AppColors.heroGradient,
    emergencyGradient: AppColors.emergencyGradient,
    successGradient: AppColors.successGradient,
  );

  static const AppPalette dark = AppPalette(
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    surfaceAlt: AppColors.surfaceAltDark,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
    textMuted: AppColors.textMutedDark,
    border: AppColors.borderDark,
    emergencySoft: Color(0xFF3A1E22),
    successSoft: Color(0xFF163027),
    infoSoft: Color(0xFF17263F),
    cardShadow: Color(0x400D1117),
    brandGradient: AppColors.brandGradient,
    heroGradient: AppColors.darkHeroGradient,
    emergencyGradient: AppColors.emergencyGradient,
    successGradient: AppColors.successGradient,
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? emergencySoft,
    Color? successSoft,
    Color? infoSoft,
    Color? cardShadow,
    Gradient? brandGradient,
    Gradient? heroGradient,
    Gradient? emergencyGradient,
    Gradient? successGradient,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      emergencySoft: emergencySoft ?? this.emergencySoft,
      successSoft: successSoft ?? this.successSoft,
      infoSoft: infoSoft ?? this.infoSoft,
      cardShadow: cardShadow ?? this.cardShadow,
      brandGradient: brandGradient ?? this.brandGradient,
      heroGradient: heroGradient ?? this.heroGradient,
      emergencyGradient: emergencyGradient ?? this.emergencyGradient,
      successGradient: successGradient ?? this.successGradient,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      emergencySoft: Color.lerp(emergencySoft, other.emergencySoft, t)!,
      successSoft: Color.lerp(successSoft, other.successSoft, t)!,
      infoSoft: Color.lerp(infoSoft, other.infoSoft, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      brandGradient: other.brandGradient,
      heroGradient: other.heroGradient,
      emergencyGradient: other.emergencyGradient,
      successGradient: other.successGradient,
    );
  }
}
