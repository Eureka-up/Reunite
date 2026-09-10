import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

/// Top bar for the found flow, extracted from `found_view.dart`.
class FoundAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoundAppBar({super.key, required this.onClose});
  final VoidCallback onClose;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.palette.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(12),
        child: Material(
          color: context.palette.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: context.palette.border)),
          child: InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(Icons.close_rounded, size: 18)),
        ),
      ),
      title: Column(children: [
        Text(context.tr('report.foundTitle'),
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w800, fontSize: 14)),
        Text(context.tr('report.foundSubtitle'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall?.copyWith(
                color: context.palette.textSecondary, fontSize: 11)),
      ]),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(100),
                border:
                    Border.all(color: AppColors.success.withValues(alpha: 0.14))),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.favorite_rounded,
                  size: 12, color: AppColors.success),
              const SizedBox(width: 4),
              Text(context.tr('report.foundSafeBadge'),
                  style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w800,
                      fontSize: 11)),
            ]),
          ),
        ),
      ],
    );
  }
}
