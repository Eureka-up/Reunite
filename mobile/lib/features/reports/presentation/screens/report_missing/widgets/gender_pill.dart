import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class MissingGenderPill extends StatelessWidget {
  const MissingGenderPill({super.key, required this.label, required this.icon, required this.selected, required this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: 220.ms,
            height: 48,
            decoration: BoxDecoration(gradient: selected ? AppColors.brandGradient : null, color: selected ? null : context.palette.surfaceAlt, borderRadius: BorderRadius.circular(14), border: Border.all(color: selected ? Colors.transparent : context.palette.border)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 18, color: selected ? Colors.white : context.palette.textSecondary), const SizedBox(width: 8), Text(label, style: context.textTheme.labelLarge?.copyWith(color: selected ? Colors.white : context.palette.textPrimary, fontWeight: FontWeight.w700))]),
          ),
        ),
      ),
    );
  }
}
