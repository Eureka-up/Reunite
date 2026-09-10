import 'package:flutter/material.dart';

import '../utils/context_extensions.dart';

/// Skeleton loading placeholders (shimmer).
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, this.width, this.height, this.radius = 8});

  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration.zero,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.palette.surfaceAlt,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
