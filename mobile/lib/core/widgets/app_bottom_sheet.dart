import 'package:flutter/material.dart';

import '../utils/context_extensions.dart';

/// Default modal bottom sheet with safe-area handling.
Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  bool scrollable = true,
  double? maxHeight,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: BoxConstraints(maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height * 0.85),
    backgroundColor: context.palette.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => scrollable
        ? SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: child,
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: child,
          ),
  );
}