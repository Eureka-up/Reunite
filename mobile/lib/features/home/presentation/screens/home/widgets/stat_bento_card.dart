import 'package:flutter/material.dart';

import '../../../../../../core/utils/context_extensions.dart';

class StatBentoCard extends StatelessWidget {
  const StatBentoCard({
    super.key,
    required this.value,
    required this.label,
    required this.subLabel,
    required this.icon,
    required this.gradient,
    required this.bg,
  });
  final int value;
  final String label;
  final String subLabel;
  final IconData icon;
  final Gradient gradient;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: context.palette.border),
        boxShadow: [BoxShadow(color: context.palette.cardShadow, blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [BoxShadow(color: (gradient.colors.first).withValues(alpha: 0.30), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(100)),
                child: Text(subLabel, style: context.textTheme.labelSmall?.copyWith(fontSize: 10, color: gradient.colors.first, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$value',
            style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, height: 1, fontFeatures: const [FontFeature.tabularFigures()]),
          ),
          const SizedBox(height: 4),
          Text(label, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: (value.clamp(0, 100)) / 100,
              minHeight: 4,
              backgroundColor: context.palette.surfaceAlt,
              valueColor: AlwaysStoppedAnimation<Color>(gradient.colors.first),
            ),
          ),
        ],
      ),
    );
  }
}
