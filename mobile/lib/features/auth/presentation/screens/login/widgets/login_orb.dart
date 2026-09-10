import 'package:flutter/material.dart';

// ── Decorative orb ──
class LoginOrb extends StatelessWidget {
  const LoginOrb({super.key, required this.size, required this.color});
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
