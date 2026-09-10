import 'package:flutter/material.dart';

import '../../../core/utils/context_extensions.dart';
import 'app_bottom_sheet.dart';

/// Section title with optional trailing action.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.trailingLabel,
    this.onTrailingTap,
  });

  final String title;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: context.textTheme.titleLarge),
        ),
        if (trailingLabel != null)
          TextButton(
            onPressed: onTrailingTap,
            child: Text(trailingLabel!,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.secondary,
                )),
          ),
      ],
    );
  }
}

/// Shows a full-screen selector sheet (e.g. language picker).
Future<T?> showSelectionSheet<T>({
  required BuildContext context,
  required String title,
  required List<(T, String, IconData)> options,
  required T current,
}) {
  return showAppBottomSheet<T>(
    context,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.titleLarge),
        const SizedBox(height: 8),
        for (final (value, label, icon) in options)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(icon, color: context.colorScheme.secondary),
            title: Text(label, style: context.textTheme.bodyLarge),
            trailing: value == current
                ? Icon(Icons.check_circle, color: context.colorScheme.secondary)
                : null,
            onTap: () => Navigator.pop(context, value),
          ),
      ],
    ),
  );
}