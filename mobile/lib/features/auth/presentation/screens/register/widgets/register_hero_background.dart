import 'package:flutter/material.dart';

import 'register_orb.dart';

class RegisterHeroBackground extends StatelessWidget {
  const RegisterHeroBackground({super.key, required this.width});

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
            child: RegisterOrb(
              size: 180,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            top: 80,
            right: -30,
            child: RegisterOrb(
              size: 120,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          Positioned(
            bottom: 20,
            left: width * 0.3,
            child: RegisterOrb(
              size: 80,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ],
      ),
    );
  }
}
