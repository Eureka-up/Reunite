import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class ModernNotificationBell extends StatelessWidget {
  const ModernNotificationBell({super.key, required this.unreadCount});
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: context.palette.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: context.palette.border),
          ),
          elevation: 0,
          child: InkWell(
            onTap: () => AutoTabsRouter.of(context).setActiveIndex(3),
            borderRadius: BorderRadius.circular(14),
            child: const SizedBox(
              width: 44,
              height: 44,
              child: Icon(Icons.notifications_none_rounded, size: 22),
            ),
          ),
        ),
        if (unreadCount > 0)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                gradient: AppColors.emergencyGradient,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: context.palette.surface, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emergency.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
              child: Text(
                unreadCount > 99 ? '99+' : '$unreadCount',
                textAlign: TextAlign.center,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.08, 1.08),
                  duration: 900.ms,
                ),
          ),
      ],
    );
  }
}
