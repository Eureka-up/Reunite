import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';

class RegisterBrandAvatar extends StatelessWidget {
  const RegisterBrandAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.brandGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(
          Icons.person_add_rounded,
          color: Colors.white,
          size: 28,
        ),
      ).animate().scale(
            begin: const Offset(0.7, 0.7),
            duration: 500.ms,
            curve: Curves.easeOutBack,
          ).fadeIn(delay: 450.ms),
    );
  }
}
