import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';
import 'app_button.dart';

/// Attractive empty state with an illustration and friendly copy.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.sentiment_dissatisfied_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: context.palette.surfaceAlt,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 46, color: context.palette.textMuted),
            )
                .animate()
                .scale(duration: 500.ms, curve: Curves.easeOutBack)
                .then()
                .shake(hz: 6, duration: 300.ms, curve: Curves.easeInOut),
            const SizedBox(height: AppDimens.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: AppDimens.sm),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.palette.textSecondary,
              ),
            ),
            if (actionLabel != null) ...[
              const SizedBox(height: AppDimens.xl),
              AppButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
