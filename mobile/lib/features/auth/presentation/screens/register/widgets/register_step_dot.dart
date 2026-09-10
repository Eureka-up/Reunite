import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

// ── Step dots for multi-step indicator ──
class RegisterStepDot extends StatelessWidget {
  const RegisterStepDot({super.key, required this.active, required this.label});
  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.white : Colors.white.withValues(alpha: 0.2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: active ? AppColors.primary : Colors.white,
        ),
      ),
    );
  }
}

// ── Step line ──
