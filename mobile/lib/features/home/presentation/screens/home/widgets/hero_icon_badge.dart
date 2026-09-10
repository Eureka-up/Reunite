import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroIconBadge extends StatelessWidget {
  const HeroIconBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 34),
    ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack);
  }
}
