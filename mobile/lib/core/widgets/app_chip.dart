import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';

/// Filter pill used in toolbars; shows a leading indicator dot via [dotColor].
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    this.label,
    this.selected = false,
    this.onTap,
    this.icon,
    this.dotColor,
    this.labelStyle,
  });

  final String? label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? dotColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final Color bg = selected ? context.colorScheme.secondary : context.palette.surfaceAlt;
    final Color fg = selected
        ? Colors.white
        : context.palette.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        child: AnimatedContainer(
          duration: 180.ms,
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.lg,
            vertical: AppDimens.sm + 2,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
            border: Border.all(
              color: selected ? Colors.transparent : context.palette.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dotColor != null) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
              ],
              if (icon != null) ...[
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: 6),
              ],
              if (label != null)
                Text(
                  label!,
                  style: labelStyle ?? context.textTheme.labelMedium?.copyWith(color: fg),
                ),
            ],
          ),
        ),
      ),
    );
  }
}