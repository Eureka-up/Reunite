import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../utils/image_util.dart';

/// Renders a child's photo: a demo illustration avatar when given a seed,
/// or the actual image when given a real file path.
class ChildPhoto extends StatelessWidget {
  const ChildPhoto({
    super.key,
    required this.seed,
    this.radius,
    this.size,
    this.imagePath,
    this.onTap,
    this.borderRadius,
  });

  final String? seed;
  final String? imagePath;
  final double? radius;
  final double? size;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final double dim = size ?? radius ?? 0;
    final Color color = ImageUtil.colorFor(seed ?? 'child');

    final Widget content = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(AppDimens.radiusMd),
      child: Container(
        width: radius != null ? null : dim,
        height: radius != null ? null : dim,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withValues(alpha: 0.7)],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.child_care_rounded,
            color: Colors.white.withValues(alpha: 0.9),
            size: radius != null ? radius! * 0.8 : dim * 0.4,
          ),
        ),
      ),
    );

    final Widget wrapped = onTap == null
        ? content
        : InkWell(onTap: onTap, borderRadius: borderRadius, child: content);

    if (radius == null) return wrapped;

    return SizedBox(
      width: radius,
      height: radius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        child: wrapped,
      ),
    );
  }
}