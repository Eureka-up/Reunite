import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/theme/app_colors.dart';

class HeroArt extends StatelessWidget {
  const HeroArt({
    super.key,
    required this.icon,
    required this.accent,
    required this.active,
  });
  final IconData icon;
  final Color accent;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [accent.withValues(alpha: 0.12), Colors.transparent],
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.06),
              border: Border.all(
                color: accent.withValues(alpha: 0.10),
                width: 1,
              ),
            ),
          ),
          Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [accent, accent.withValues(alpha: 0.8)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 48),
              )
              .animate(target: active ? 1 : 0)
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1, 1),
                duration: 520.ms,
                curve: Curves.easeOutBack,
              ),
          Positioned(
            top: 8,
            right: 20,
            child:
                Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    )
                    .animate(target: active ? 1 : 0)
                    .scale(delay: 220.ms, duration: 360.ms)
                    .fadeIn(delay: 220.ms),
          ),
          Positioned(
            bottom: 12,
            left: 24,
            child:
                Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    )
                    .animate(target: active ? 1 : 0)
                    .scale(delay: 320.ms, duration: 360.ms)
                    .fadeIn(delay: 320.ms),
          ),
        ],
      ),
    );
  }
}
