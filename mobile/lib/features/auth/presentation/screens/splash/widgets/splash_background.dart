import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import 'splash_blur_orb.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -90,
          left: -70,
          child: SplashBlurOrb(
            size: 260,
            color: Colors.white.withValues(alpha: 0.10),
          ),
        ),
        Positioned(
          bottom: -110,
          right: -80,
          child: SplashBlurOrb(
            size: 340,
            color: AppColors.secondary.withValues(alpha: 0.22),
          ),
        ),
        Positioned(
          top: 160,
          right: -30,
          child: SplashBlurOrb(
            size: 180,
            color: AppColors.accent.withValues(alpha: 0.14),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.04),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
