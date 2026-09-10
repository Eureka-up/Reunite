import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../theme/app_dimens.dart';
import '../utils/context_extensions.dart';
import 'widgets.dart';

/// A compact info row used in the review step of report forms.
class ReviewRow extends StatelessWidget {
  const ReviewRow({
    super.key,
    required this.label,
    this.value,
    this.icon,
  });

  final String label;
  final String? value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: context.colorScheme.secondary),
            const SizedBox(width: 8),
          ],
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.palette.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(value ?? context.tr('common.unknown'),
                style: context.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

/// Section divider for multi-step forms.
class FormSectionTitle extends StatelessWidget {
  const FormSectionTitle({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.titleLarge),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.palette.textSecondary,
              )),
        ],
      ],
    );
  }
}

/// Confirmation footer with a primary action.
class FormActionsBar extends StatelessWidget {
  const FormActionsBar({
    super.key,
    required this.onBack,
    required this.onNext,
    this.nextLabel,
    this.primary = true,
    this.loading = false,
  });

  final VoidCallback onBack;
  final VoidCallback onNext;
  final String? nextLabel;
  final bool primary;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          label: nextLabel ?? context.tr('common.next'),
          gradient: const LinearGradient(colors: [
            Color(0xFF164A86),
            Color(0xFF1BB8A3),
          ]),
          onPressed: onNext,
          loading: loading,
        ),
        const SizedBox(height: AppDimens.sm),
        TextButton(onPressed: onBack, child: Text(context.tr('common.back'))),
      ],
    );
  }
}
