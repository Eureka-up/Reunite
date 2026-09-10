import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

/// Top bar for the missing flow, extracted from `missing_view.dart`.
class MissingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MissingAppBar({super.key, required this.step, required this.onBack});
  final int step;
  final VoidCallback onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  static const stepLabels = ['Photo', 'Info', 'Date', 'Look', 'Contact', 'Review'];
  static const total = 6;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.palette.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Material(
          color: context.palette.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: context.palette.border)),
          child: InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(12),
            child: Icon(step > 0 ? Icons.arrow_back_rounded : Icons.close_rounded,
                size: 18, color: context.palette.textPrimary),
          ),
        ),
      ),
      title: Column(
        children: [
          Text(context.tr('report.missingTitle'),
              style: context.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w800, fontSize: 14)),
          Text('${step + 1} / $total • ${stepLabels[step]}',
              style: context.textTheme.labelSmall?.copyWith(
                  color: context.palette.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: AppColors.emergency.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: AppColors.emergency.withValues(alpha: 0.14))),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.priority_high_rounded,
                  size: 12, color: AppColors.emergency),
              const SizedBox(width: 4),
              Text('Urgent',
                  style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.emergency,
                      fontWeight: FontWeight.w800,
                      fontSize: 11)),
            ]),
          ),
        ),
      ],
    );
  }
}
