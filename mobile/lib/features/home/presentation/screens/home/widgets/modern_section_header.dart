import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class ModernSectionHeader extends StatelessWidget {
  const ModernSectionHeader({
    super.key,
    required this.icon,
    this.iconBg,
    required this.title,
    this.subtitle,
    this.trailingLabel,
    this.onTrailingTap,
  });
  final IconData icon;
  final Color? iconBg;
  final String title;
  final String? subtitle;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: (iconBg ?? AppColors.primary).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: (iconBg ?? AppColors.primary).withValues(alpha: 0.18)),
          ),
          child: Icon(icon, size: 22, color: iconBg ?? AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, height: 1.1)),
              if (subtitle != null)
                Text(subtitle!, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (trailingLabel != null)
          Material(
            color: context.palette.surface,
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: onTrailingTap,
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: context.palette.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      trailingLabel!,
                      style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.primary, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, size: 14, color: context.colorScheme.primary),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
