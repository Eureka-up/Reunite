import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/utils/context_extensions.dart';

/// Animated counting stat card.
class StatCard extends StatefulWidget {
  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.color = AppColors.primary,
    this.bg,
  });

  final int value;
  final String label;
  final IconData icon;
  final Color color;
  final Color? bg;

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _progress = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final int shown = (_progress * widget.value).round();
    return Container(
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(color: context.palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.bg ?? widget.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: Icon(widget.icon, color: widget.color, size: 21),
          ),
          const SizedBox(height: AppDimens.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$shown',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: widget.color,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: 6),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.label,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.palette.textSecondary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15);
  }
}