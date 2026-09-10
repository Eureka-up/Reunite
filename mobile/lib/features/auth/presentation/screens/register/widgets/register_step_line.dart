import 'package:flutter/material.dart';

// ── Step line ──
class RegisterStepLine extends StatelessWidget {
  const RegisterStepLine({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

// ── Section label ──
