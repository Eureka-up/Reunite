import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/context_extensions.dart';

/// Confirmation dialog reused across the app.
Future<bool?> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
  bool destructive = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: context.palette.surface,
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel ?? context.tr('common.cancel')),
        ),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: context.colorScheme.error,
                )
              : null,
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel ??
              (destructive ? context.tr('common.submit') : context.tr('common.done'))),
        ),
      ],
    ),
  );
}