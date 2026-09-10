import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key, required this.total, required this.unread, required this.emergency, this.onMarkAll});
  final int total;
  final int unread;
  final int emergency;
  final VoidCallback? onMarkAll;

  @override
  Widget build(BuildContext context) {
    final hasUnread = unread > 0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primary, AppColors.primaryLight, const Color(0xFF2EC4B6)]),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.26), blurRadius: 28, offset: const Offset(0, 12))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // mesh orbs
              Positioned(top: -36, right: -30, child: Container(width: 150, height: 150, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.11), shape: BoxShape.circle))),
              Positioned(bottom: -46, left: -28, child: Container(width: 180, height: 180, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.07), shape: BoxShape.circle))),
              Positioned(top: 22, left: 22, child: Container(width: 54, height: 54, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withValues(alpha: 0.18))), child: const Icon(Icons.notifications_rounded, color: Colors.white, size: 28))),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.tr('notifications.title'), style: context.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1)),
                              const SizedBox(height: 4),
                              Text(hasUnread ? '$unread unread • $total total' : '$total notifications', style: context.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.86), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        if (hasUnread)
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              onTap: onMarkAll,
                              borderRadius: BorderRadius.circular(100),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                  const Icon(Icons.done_all_rounded, size: 16, color: AppColors.primary),
                                  const SizedBox(width: 6),
                                  Text(context.tr('notifications.markAllRead'), style: context.textTheme.labelSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 11)),
                                ]),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // mini stats row — urgent removed
                    Row(
                      children: [
                        MiniStat(value: '$total', label: context.tr('notifications.total'), icon: Icons.layers_rounded),
                        const SizedBox(width: 10),
                        MiniStat(value: '$unread', label: context.tr('notifications.unread'), icon: Icons.mark_email_unread_rounded, highlight: hasUnread),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 420.ms).slideY(begin: 0.05);
  }
}

class MiniStat extends StatelessWidget {
  const MiniStat({super.key, required this.value, required this.label, required this.icon, this.highlight = false, this.highlightColor});
  final String value;
  final String label;
  final IconData icon;
  final bool highlight;
  final Color? highlightColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: highlight ? (highlightColor ?? AppColors.primary).withValues(alpha: 0.14) : Colors.white.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: highlight ? 0.18 : 0.14)),
        ),
        child: Row(
          children: [
            Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.92), borderRadius: BorderRadius.circular(9)), child: Icon(icon, size: 16, color: highlight ? (highlightColor ?? AppColors.primary) : AppColors.primary)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: context.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1)),
                  Text(label, style: context.textTheme.labelSmall?.copyWith(color: Colors.white.withValues(alpha: 0.78), fontSize: 10, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
