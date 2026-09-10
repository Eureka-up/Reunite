import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class MissingStepper extends StatelessWidget {
  const MissingStepper({super.key, required this.step, required this.total, required this.icons, required this.labels});
  final int step;
  final int total;
  final List<IconData> icons;
  final List<String> labels;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(total, (i) {
            final active = i == step;
            final done = i < step;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == total - 1 ? 0 : 6),
                child: AnimatedContainer(
                  duration: 300.ms,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: active ? const LinearGradient(colors: [Color(0xFF0F172A), Color(0xFF009688)]) : null,
                    color: done ? AppColors.success : active ? null : context.palette.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: active ? Colors.transparent : done ? AppColors.success : context.palette.border, width: active || done ? 1.5 : 1),
                    boxShadow: active ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.18), blurRadius: 12, offset: const Offset(0, 4))] : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(done ? Icons.check_rounded : icons[i], size: 16, color: active || done ? Colors.white : context.palette.textMuted),
                      if (active) ...[const SizedBox(width: 6), Flexible(child: Text(labels[i], maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11)))],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(value: (step + 1) / total, minHeight: 4, backgroundColor: context.palette.surfaceAlt, valueColor: const AlwaysStoppedAnimation(AppColors.primary)),
        ),
      ],
    );
  }
}
