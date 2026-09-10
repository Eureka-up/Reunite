import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/utils/context_extensions.dart';
import '../widgets/login_hero_background.dart';
import '../widgets/login_top_bar.dart';

class LoginHeroSection extends StatelessWidget {
  const LoginHeroSection({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: LoginHeroBackground(width: size.width),
          ),
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: LoginHeroBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginHeroBody extends StatelessWidget {
  const LoginHeroBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginTopBar(),
        const Spacer(),
        Text(
          context.tr('auth.loginSubtitle'),
          style: context.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.85),
          ),
        )
            .animate()
            .fadeIn(delay: 350.ms, duration: 500.ms)
            .slideX(begin: -0.06, end: 0),
        const SizedBox(height: 16),
      ],
    );
  }
}
