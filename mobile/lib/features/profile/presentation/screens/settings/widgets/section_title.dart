import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 18, color: AppColors.primary)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, height: 1.1)),
            Text(subtitle, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary, fontSize: 11)),
          ]),
        ),
      ],
    );
  }
}
