import 'package:flutter/material.dart';

import 'login_orb.dart';

class LoginHeroBackground extends StatelessWidget {
  const LoginHeroBackground({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00796B),
            Color(0xFF009688),
            Color(0xFF4DB6AC),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            left: -40,
            child: LoginOrb(
              size: 180,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            top: 80,
            right: -30,
            child: LoginOrb(
              size: 120,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          Positioned(
            bottom: 20,
            left: width * 0.3,
            child: LoginOrb(
              size: 80,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ],
      ),
    );
  }
}
