import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class SettingsHero extends StatelessWidget {
  const SettingsHero({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0F172A), Color(0xFF1E3A5F), Color(0xFF009688)]),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: const Color(0xFF0F172A).withValues(alpha: 0.18), blurRadius: 24, offset: const Offset(0, 10))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            Positioned(top: -30, right: -30, child: Container(width: 140, height: 140, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.07), shape: BoxShape.circle))),
            Positioned(bottom: -40, left: -30, child: Container(width: 160, height: 160, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), shape: BoxShape.circle))),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withValues(alpha: 0.18))),
                    child: const Icon(Icons.tune_rounded, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.tr('settings.personalize'), style: context.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1)),
                        const SizedBox(height: 3),
                        Text(context.tr('settings.personalizeSub'), style: context.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.78), height: 1.3)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.verified_rounded, size: 14, color: AppColors.primary), const SizedBox(width: 4), Text(context.tr('settings.synced'), style: context.textTheme.labelSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 11))]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 380.ms).slideY(begin: 0.06);
  }
}
