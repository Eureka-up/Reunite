import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import 'hero_actions_row.dart';
import 'hero_eyebrow_pill.dart';
import 'hero_icon_badge.dart';
import 'hero_trust_row.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key, required this.onSearchTap});
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppDimens.xl, AppDimens.md, AppDimens.xl, AppDimens.lg),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.heroGradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.28),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              const _BackdropOrbs(),
              const _GridOverlay(),
              const Positioned(top: 24, left: 24, child: HeroIconBadge()),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeroEyebrowPill(),
                    const SizedBox(height: 16),
                    Text(
                      context.tr('home.heroTitle'),
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.tr('home.heroSubtitle'),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.92),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const HeroActionsRow(),
                    const SizedBox(height: 14),
                    const HeroTrustRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackdropOrbs extends StatelessWidget {
  const _BackdropOrbs();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: _Orb(size: 160, opacity: 0.10),
          ),
          Positioned(
            bottom: -60,
            left: -30,
            child: _Orb(size: 200, opacity: 0.07),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.opacity});
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _GridOverlay extends StatelessWidget {
  const _GridOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.06),
              Colors.transparent,
              Colors.black.withValues(alpha: 0.10),
            ],
          ),
        ),
      ),
    );
  }
}
