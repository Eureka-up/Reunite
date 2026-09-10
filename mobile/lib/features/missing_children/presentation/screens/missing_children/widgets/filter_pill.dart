import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class FilterPill extends StatelessWidget {
  const FilterPill({super.key, required this.label, required this.icon, this.selected = false, this.dotColor, this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final Color? dotColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? context.colorScheme.primary : context.palette.surface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: selected ? context.colorScheme.primary : context.palette.border),
            boxShadow: selected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.20), blurRadius: 10, offset: const Offset(0, 4))] : null,
          ),
          child: Row(
            children: [
              if (dotColor != null) ...[Container(width: 7, height: 7, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)), const SizedBox(width: 6)],
              Icon(icon, size: 16, color: selected ? Colors.white : context.palette.textSecondary),
              const SizedBox(width: 6),
              Text(label, style: context.textTheme.labelMedium?.copyWith(color: selected ? Colors.white : context.palette.textPrimary, fontWeight: FontWeight.w700, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
