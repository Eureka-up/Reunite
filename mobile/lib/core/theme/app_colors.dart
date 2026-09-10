import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Modern brand — teal primary + coral secondary
  static const Color navy = Color(0xFF1A1A2E);
  static const Color navyDeep = Color(0xFF0F0F1A);
  static const Color primary = Color(0xFF009688);
  static const Color primaryLight = Color(0xFF4DB6AC);
  static const Color primaryDark = Color(0xFF00796B);
  static const Color secondary = Color(0xFFFF7043);
  static const Color secondaryLight = Color(0xFFFF8A65);

  // Semantic
  static const Color accent = Color(0xFFFFB74D);
  static const Color accentLight = Color(0xFFFFCC80);
  static const Color emergency = Color(0xFFEF4444);
  static const Color emergencySoft = Color(0xFFFEF2F2);
  static const Color success = Color(0xFF4CAF50);
  static const Color successSoft = Color(0xFFE8F5E9);
  static const Color info = Color(0xFF42A5F5);
  static const Color infoSoft = Color(0xFFE3F2FD);
  static const Color warning = Color(0xFFFFA726);

  // Light neutrals — clean warm
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceAltLight = Color(0xFFF1F3F5);
  static const Color textPrimaryLight = Color(0xFF212529);
  static const Color textSecondaryLight = Color(0xFF6C757D);
  static const Color textMutedLight = Color(0xFFADB5BD);
  static const Color borderLight = Color(0xFFDEE2E6);

  // Dark neutrals — deep modern dark
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color surfaceDark = Color(0xFF161B22);
  static const Color surfaceAltDark = Color(0xFF21262D);
  static const Color textPrimaryDark = Color(0xFFF0F6FC);
  static const Color textSecondaryDark = Color(0xFF8B949E);
  static const Color textMutedDark = Color(0xFF6E7681);
  static const Color borderDark = Color(0xFF30363D);

  // Modern gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00796B), Color(0xFF009688), Color(0xFF4DB6AC)],
  );

  static const LinearGradient darkHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF009688), Color(0xFF4DB6AC), Color(0xFF0D1117)],
  );

  static const LinearGradient emergencyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF388E3C), Color(0xFF4CAF50)],
  );

  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF7043), Color(0xFFFFB74D)],
  );

  static const LinearGradient coolGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF009688), Color(0xFF42A5F5)],
  );

  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF1F3F5)],
  );

  static const LinearGradient darkGlassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF21262D), Color(0xFF161B22)],
  );
}
