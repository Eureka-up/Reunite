import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class ImpactRow extends StatelessWidget {
  const ImpactRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImpactCard(icon: Icons.volunteer_activism_rounded, label: 'Volunteer', value: 'Level 3', color: AppColors.primary, gradient: AppColors.brandGradient),
        const SizedBox(width: 10),
        ImpactCard(icon: Icons.emoji_events_rounded, label: 'Badges', value: '6 earned', color: AppColors.accent, gradient: AppColors.warmGradient),
        const SizedBox(width: 10),
        ImpactCard(icon: Icons.shield_rounded, label: 'Trust', value: '98%', color: AppColors.success, gradient: AppColors.successGradient),
      ],
    );
  }
}

class ImpactCard extends StatelessWidget {
  const ImpactCard({super.key, required this.icon, required this.label, required this.value, required this.color, required this.gradient});
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Gradient gradient;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: context.palette.border), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))]),
        child: Column(
          children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(11), boxShadow: [BoxShadow(color: color.withValues(alpha: 0.22), blurRadius: 10, offset: const Offset(0, 4))]), child: Icon(icon, size: 18, color: Colors.white)),
            const SizedBox(height: 8),
            Text(value, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900, fontSize: 13, height: 1)),
            Text(label, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
