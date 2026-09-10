import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({super.key, required this.label, required this.count});
  final String label;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: context.palette.surfaceAlt, borderRadius: BorderRadius.circular(100)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.calendar_today_rounded, size: 12, color: context.palette.textSecondary), const SizedBox(width: 6), Text(label, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary, fontWeight: FontWeight.w800, fontSize: 11))]),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(100)),
            child: Text('$count', style: context.textTheme.labelSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 11)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Divider(color: context.palette.border, height: 1)),
        ],
      ),
    );
  }
}
