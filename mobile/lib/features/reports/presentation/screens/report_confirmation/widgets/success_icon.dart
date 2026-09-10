import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';

class ConfirmationSuccessIcon extends StatelessWidget {
  const ConfirmationSuccessIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.successGradient,
      ),
      child: const Icon(Icons.check_rounded, color: Colors.white, size: 60),
    ).animate().scale(
          begin: const Offset(0.4, 0.4),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }
}
