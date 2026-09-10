import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class NavItem extends StatelessWidget {
  const NavItem({super.key, required this.icon, this.activeIcon, required this.label, required this.selected, required this.onTap, this.showDot = false});
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final active = selected;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: 200.ms,
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(color: active ? AppColors.primary.withValues(alpha: 0.09) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(active ? (activeIcon ?? icon) : icon, size: 22, color: active ? AppColors.primary : context.palette.textMuted),
                    if (showDot && active)
                      Positioned(right: -4, top: -2, child: Container(width: 7, height: 7, decoration: BoxDecoration(color: AppColors.emergency, shape: BoxShape.circle, border: Border.all(color: context.palette.surface, width: 1.4)))),
                  ],
                ),
                const SizedBox(height: 2),
                Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textTheme.labelSmall?.copyWith(color: active ? AppColors.primary : context.palette.textMuted, fontWeight: active ? FontWeight.w700 : FontWeight.w500, fontSize: 10.5, height: 1)),
                const SizedBox(height: 3),
                AnimatedContainer(duration: 200.ms, height: 2.5, width: active ? 14 : 0, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(100))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
