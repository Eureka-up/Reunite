import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class MissingReviewRow extends StatelessWidget {
  const MissingReviewRow({super.key, required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final has = value.trim().isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(width: 34, height: 34, decoration: BoxDecoration(color: context.palette.surfaceAlt, borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 16, color: context.palette.textSecondary)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textMuted, fontWeight: FontWeight.w600, fontSize: 11)), Text(has ? value : context.tr('common.unknown'), maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textTheme.bodyMedium?.copyWith(fontWeight: has ? FontWeight.w600 : FontWeight.w400, color: has ? context.palette.textPrimary : context.palette.textMuted))])),
          const SizedBox(width: 8),
          Icon(has ? Icons.check_circle_rounded : Icons.help_outline_rounded, size: 16, color: has ? AppColors.success : context.palette.textMuted),
        ],
      ),
    );
  }
}
