import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';

class VeryModernEmpty extends StatelessWidget {
  const VeryModernEmpty({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.24), blurRadius: 20, offset: const Offset(0, 10))]),
              child: const Icon(Icons.notifications_none_rounded, size: 44, color: Colors.white),
            ).animate().scale(delay: 120.ms, duration: 520.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 18),
            Text(context.tr('notifications.empty'), style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text(context.tr('notifications.emptySub'), textAlign: TextAlign.center, style: context.textTheme.bodyMedium?.copyWith(color: context.palette.textSecondary, height: 1.5)),
            const SizedBox(height: 22),
            AppButton(label: 'Explore cases', icon: Icons.explore_rounded, gradient: AppColors.brandGradient, onPressed: () => context.router.navigate(const MissingChildrenRoute())),
          ],
        ),
      ),
    );
  }
}

class ModernSkeleton extends StatelessWidget {
  const ModernSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => const AppSkeleton(height: 96, radius: 20),
    );
  }
}
