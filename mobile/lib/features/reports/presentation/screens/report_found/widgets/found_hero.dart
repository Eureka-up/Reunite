import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class FoundHero extends StatelessWidget {
  const FoundHero({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0B3D2E), Color(0xFF0F766E), Color(0xFF14B8A6)]), borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: const Color(0xFF0B3D2E).withValues(alpha: 0.18), blurRadius: 22, offset: const Offset(0, 10))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(top: -28, right: -28, child: Container(width: 120, height: 120, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.07), shape: BoxShape.circle))),
            Positioned(bottom: -36, left: -30, child: Container(width: 160, height: 160, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), shape: BoxShape.circle))),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withValues(alpha: 0.18))), child: const Icon(Icons.child_friendly_rounded, color: Colors.white, size: 26)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.tr('report.foundHeroTitle'), style: context.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1.1)), const SizedBox(height: 3), Text(context.tr('report.foundHeroSubtitle'), style: context.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.82), height: 1.35, fontSize: 12))])),
                  ]),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.11), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withValues(alpha: 0.14))),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 32, height: 32, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.shield_rounded, size: 18, color: Color(0xFF0F766E))), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.tr('report.safetyTitle'), style: context.textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)), const SizedBox(height: 2), Text(context.tr('report.safetyBody'), style: context.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.88), height: 1.4, fontSize: 11))]))]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoundQuickCheck extends StatelessWidget {
  const FoundQuickCheck({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.success.withValues(alpha: 0.12))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.checklist_rounded, size: 18, color: AppColors.success)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.tr('report.foundQuickCheck'), style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, fontSize: 13)), const SizedBox(height: 2), Text(context.tr('report.foundQuickCheckSub'), style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary, height: 1.4, fontSize: 12))]))]),
    );
  }
}

class FoundLocationHint extends StatelessWidget {
  const FoundLocationHint({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: AppColors.info.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.info.withValues(alpha: 0.10))),
      child: Row(children: [const Icon(Icons.my_location_rounded, size: 16, color: AppColors.info), const SizedBox(width: 8), Expanded(child: Text(context.tr('report.currentLocation'), style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary, fontSize: 12))), TextButton(onPressed: () {}, child: Text(context.tr('map.allow'), style: context.textTheme.labelSmall?.copyWith(color: AppColors.info, fontWeight: FontWeight.w800)))]),
    );
  }
}
