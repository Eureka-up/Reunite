import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';

class DiscoverAppBar extends StatelessWidget {
  const DiscoverAppBar({super.key, required this.count, required this.onMapTap});
  final int count;
  final VoidCallback onMapTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.palette.background.withValues(alpha: 0.88),
      surfaceTintColor: Colors.transparent,
      expandedHeight: 108,
      collapsedHeight: 64,
      flexibleSpace: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            color: context.palette.background.withValues(alpha: 0.76),
            border: Border(bottom: BorderSide(color: context.palette.border.withValues(alpha: 0.6))),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppDimens.xl, 10, AppDimens.xl, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(gradient: AppColors.coolGradient, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: AppColors.info.withValues(alpha: 0.22), blurRadius: 12, offset: const Offset(0, 4))]),
                    child: const Icon(Icons.explore_rounded, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(context.tr('missing.title'), style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, height: 1)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                              decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(100)),
                              child: Text('$count', style: context.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(context.tr('missing.subtitle'), style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleIconButton(icon: Icons.map_rounded, onTap: onMapTap),
                  const SizedBox(width: 8),
                  CircleIconButton(icon: Icons.tune_rounded, onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.palette.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: context.palette.border)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(width: 44, height: 44, child: Icon(icon, size: 20, color: context.palette.textPrimary)),
      ),
    );
  }
}
