import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/utils/context_extensions.dart';
import 'hero_art.dart';

class OnboardSlide extends StatelessWidget {
  const OnboardSlide({super.key, 
    required this.index,
    required this.icon,
    required this.accent,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.features,
    required this.active,
  });

  final int index;
  final IconData icon;
  final Color accent;
  final String eyebrow;
  final String title;
  final String subtitle;
  final List<String> features;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
      child: Column(
        children: [
          const SizedBox(height: 8),
          HeroArt(icon: icon, accent: accent, active: active),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '0${index + 1}  •  $eyebrow',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.palette.textPrimary,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
              )
              .animate(target: active ? 1 : 0)
              .fadeIn(delay: 80.ms, duration: 420.ms)
              .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),
          const SizedBox(height: 12),
          Text(
                subtitle,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.palette.textSecondary,
                  height: 1.6,
                ),
              )
              .animate(target: active ? 1 : 0)
              .fadeIn(delay: 160.ms, duration: 420.ms)
              .slideY(begin: 0.10, end: 0),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final f in features)
                Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: context.palette.surface,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: context.palette.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: accent,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            f,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.palette.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate(target: active ? 1 : 0)
                    .fadeIn(
                      delay: (120 + features.indexOf(f) * 70).ms,
                      duration: 360.ms,
                    )
                    .slideY(begin: 0.12, end: 0),
            ],
          ),
        ],
      ),
    );
  }
}
