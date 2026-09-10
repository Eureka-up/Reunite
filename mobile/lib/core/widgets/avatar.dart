import 'package:flutter/material.dart';
import 'package:reunitee_app/core/theme/app_dimens.dart';

/// Initials-based avatar with optional image and online ring.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.label,
    this.radius = AppDimens.avatarSize / 2,
    this.imagePath,
    this.badge,
  });

  final String label;
  final double radius;
  final String? imagePath;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final Widget circle;
    if (imagePath != null) {
      circle = CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imagePath!),
      );
    } else {
      circle = CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Text(
          label,
          style: TextStyle(
            fontSize: radius * 0.7,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        circle,
        if (badge != null) Positioned(right: -2, bottom: -2, child: badge!),
      ],
    );
  }
}