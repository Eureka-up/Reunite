import 'package:flutter/material.dart';

import '../../../core/utils/context_extensions.dart';

/// Wraps content in a max-width column for larger screens, centering and
/// capping readability.
class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.child,
    this.maxWidth = 560,
    this.horizontalPadding,
  });

  final Widget child;
  final double maxWidth;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final double width = context.screenWidth;
    final bool isWide = width > maxWidth;
    final double padding = horizontalPadding ?? (isWide ? (width - maxWidth) / 2 : 20);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: child,
        ),
      ),
    );
  }
}