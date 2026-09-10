import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';
import 'gradient_button.dart';

/// Primary action button supporting a gradient variant and loading state.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.gradient,
    this.icon,
    this.outlined = false,
    this.text = false,
    this.expanded = true,
    this.color,
    this.foregroundColor,
    this.small = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final Gradient? gradient;
  final IconData? icon;
  final bool outlined;
  final bool text;
  final bool expanded;
  final Color? color;
  final Color? foregroundColor;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final Gradient? grad = gradient;
    final Paint paint = Paint();
    if (grad != null) {
      paint.shader = grad.createShader(const Rect.fromLTWH(0, 0, 200, 52));
    }

    final double height =
        small ? AppDimens.buttonHeight - 10 : AppDimens.buttonHeight;

    Widget child = loading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: foregroundColor ?? (outlined || text
                  ? context.colorScheme.primary
                  : Colors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: _fg(context)),
                const SizedBox(width: AppDimens.sm),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: _fg(context),
                    fontSize: small ? 13 : null,
                  ),
                ),
              ),
            ],
          );

    final Widget wrapped;
    if (text) {
      wrapped = TextButton(
        onPressed: loading || onPressed == null ? null : onPressed,
        style: TextButton.styleFrom(
          minimumSize: Size(expanded ? double.infinity : height, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
        ),
        child: child,
      );
    } else if (outlined) {
      wrapped = OutlinedButton(
        onPressed: loading || onPressed == null ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: _fg(context),
          minimumSize: Size(expanded ? double.infinity : height, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
        ),
        child: child,
      );
    } else {
      final Widget base = ElevatedButton(
        onPressed: loading || onPressed == null ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: gradient != null ? Colors.transparent : (color ?? context.colorScheme.primary),
          foregroundColor: _fg(context),
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: Size(expanded ? double.infinity : height, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
        ),
        child: child,
      );

      if (grad != null) {
        wrapped = GradientButton(paint: paint, gradient: grad, child: base);
      } else {
        wrapped = base;
      }
    }

    return wrapped;
  }

  Color _fg(BuildContext context) {
    if (foregroundColor != null) return foregroundColor!;
    if (outlined || text) return context.colorScheme.primary;
    if (gradient != null) return Colors.white;
    if (color != null) return Colors.white;
    return Colors.white;
  }
}