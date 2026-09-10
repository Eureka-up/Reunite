import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class NotificationsFilterDelegate extends SliverPersistentHeaderDelegate {
  NotificationsFilterDelegate({required this.seg, required this.all, required this.unread, required this.emergency, required this.onChange});
  final String seg;
  final int all;
  final int unread;
  final int emergency;
  final ValueChanged<String> onChange;

  @override
  double get minExtent => 66;
  @override
  double get maxExtent => 66;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.palette.background.withValues(alpha: 0.96),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
      child: Container(
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: context.palette.surfaceAlt, borderRadius: BorderRadius.circular(100), border: Border.all(color: context.palette.border)),
        child: Row(
          children: [
            SegBtn(label: context.tr('notifications.all'), count: all, selected: seg == 'all', onTap: () => onChange('all')),
            SegBtn(label: context.tr('notifications.unread'), count: unread, selected: seg == 'unread', onTap: () => onChange('unread')),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant NotificationsFilterDelegate oldDelegate) => oldDelegate.seg != seg || oldDelegate.all != all || oldDelegate.unread != unread;
}

class SegBtn extends StatelessWidget {
  const SegBtn({super.key, required this.label, this.count, this.dot, required this.selected, required this.onTap});
  final String label;
  final int? count;
  final Color? dot;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: AnimatedContainer(
            duration: 220.ms,
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: selected ? context.palette.surface : Colors.transparent, borderRadius: BorderRadius.circular(100), boxShadow: selected ? [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 12, offset: const Offset(0, 4))] : null, border: Border.all(color: selected ? context.palette.border : Colors.transparent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (dot != null) ...[Container(width: 7, height: 7, decoration: BoxDecoration(color: dot, shape: BoxShape.circle)), const SizedBox(width: 6)],
                Text(label, style: context.textTheme.labelMedium?.copyWith(color: selected ? context.palette.textPrimary : context.palette.textSecondary, fontWeight: FontWeight.w800, fontSize: 13)),
                if (count != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: selected ? AppColors.primary.withValues(alpha: 0.10) : context.palette.surface, borderRadius: BorderRadius.circular(100)),
                    child: Text('$count', style: context.textTheme.labelSmall?.copyWith(color: selected ? AppColors.primary : context.palette.textMuted, fontWeight: FontWeight.w800, fontSize: 11)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
