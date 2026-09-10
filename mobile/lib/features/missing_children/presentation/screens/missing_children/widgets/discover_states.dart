import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';

class EmptyDiscover extends StatelessWidget {
  const EmptyDiscover({super.key, required this.onClear});
  final VoidCallback onClear;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: context.palette.border)),
      child: Column(
        children: [
          Container(width: 72, height: 72, decoration: BoxDecoration(color: AppColors.info.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.search_off_rounded, size: 36, color: AppColors.info)),
          const SizedBox(height: 16),
          Text(context.tr('missing.noResults'), textAlign: TextAlign.center, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(context.tr('missing.noResultsSub'), textAlign: TextAlign.center, style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary, height: 1.5)),
          const SizedBox(height: 18),
          AppButton(label: context.tr('common.viewAll'), icon: Icons.refresh_rounded, onPressed: onClear),
        ],
      ),
    ).animate().fadeIn(duration: 320.ms).scale(begin: const Offset(0.97, 0.97));
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.messageKey, required this.onRetry});
  final String messageKey;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: context.palette.border)),
      child: Column(
        children: [
          Container(width: 64, height: 64, decoration: BoxDecoration(color: AppColors.emergencySoft, shape: BoxShape.circle), child: const Icon(Icons.wifi_off_rounded, color: AppColors.emergency, size: 32)),
          const SizedBox(height: 14),
          Text(context.tr('errors.title'), style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(context.tr(messageKey), textAlign: TextAlign.center, style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary)),
          const SizedBox(height: 16),
          AppButton(label: context.tr('common.retry'), icon: Icons.refresh_rounded, onPressed: onRetry),
        ],
      ),
    );
  }
}

class MissingSkeletonSliver extends StatelessWidget {
  const MissingSkeletonSliver({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (_, _) => const Padding(padding: EdgeInsets.only(bottom: 14), child: ChildCardSkeleton()),
    );
  }
}
