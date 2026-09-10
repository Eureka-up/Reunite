import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class RadiusCard extends StatelessWidget {
  const RadiusCard({super.key, required this.current, required this.onChanged});
  final int current;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: context.palette.border), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.radar_rounded, color: Colors.white, size: 18)),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${(current / 1000).toStringAsFixed(0)} km radius', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)), Text('We’ll alert you within this distance', style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary, fontSize: 12))])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(100)),
                child: Text('${(current / 1000).toStringAsFixed(0)} km', style: context.textTheme.labelSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AppConstants.alertRadiusOptions.map((m) {
              final km = (m / 1000).toStringAsFixed(0);
              final sel = current == m;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onChanged(m),
                  borderRadius: BorderRadius.circular(100),
                  child: AnimatedContainer(
                    duration: 200.ms,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(color: sel ? AppColors.primary : context.palette.surfaceAlt, borderRadius: BorderRadius.circular(100), border: Border.all(color: sel ? AppColors.primary : context.palette.border)),
                    child: Text('$km ${context.tr('common.km')}', style: context.textTheme.labelMedium?.copyWith(color: sel ? Colors.white : context.palette.textPrimary, fontWeight: sel ? FontWeight.w800 : FontWeight.w600, fontSize: 13)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          // slider visual
          SliderTheme(
            data: SliderThemeData(trackHeight: 6, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10), overlayShape: const RoundSliderOverlayShape(overlayRadius: 18), activeTrackColor: AppColors.primary, inactiveTrackColor: context.palette.surfaceAlt, thumbColor: Colors.white),
            child: Slider(
              value: _toSlider(current),
              min: 0,
              max: 3,
              divisions: 3,
              onChanged: (v) => onChanged(AppConstants.alertRadiusOptions[v.round()]),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: AppConstants.alertRadiusOptions.map((m) => Text('${(m / 1000).toStringAsFixed(0)}', style: context.textTheme.labelSmall?.copyWith(color: context.palette.textMuted, fontSize: 10))).toList()),
        ],
      ),
    );
  }

  double _toSlider(int v) {
    final idx = AppConstants.alertRadiusOptions.indexOf(v);
    return idx < 0 ? 1 : idx.toDouble();
  }
}
