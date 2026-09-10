import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashTextBlock extends StatelessWidget {
  const SplashTextBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 26),
        Text(
          context.tr('app.name'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 32,
            height: 1.15,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        )
            .animate()
            .fadeIn(delay: 180.ms, duration: 500.ms)
            .slideY(begin: 0.18, end: 0, curve: Curves.easeOutCubic),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.11),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.16),
            ),
          ),
          child: Text(
            context.tr('app.tagline'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.3,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 320.ms, duration: 480.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 44),
        LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.white,
          size: 46,
        ).animate().fadeIn(delay: 520.ms, duration: 500.ms),
      ],
    );
  }
}
