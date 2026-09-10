import 'package:flutter/material.dart';

// ── Decorative orb ──
class RegisterOrb extends StatelessWidget {
  const RegisterOrb({super.key, required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// ── Step dots for multi-step indicator ──
