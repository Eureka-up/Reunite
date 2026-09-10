import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class ThemeGrid extends StatelessWidget {
  const ThemeGrid({super.key, required this.mode, required this.onChanged});
  final ThemeMode mode;
  final ValueChanged<ThemeMode> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ThemeCard(icon: Icons.brightness_auto_rounded, label: context.tr('profile.systemMode'), desc: 'Auto', selected: mode == ThemeMode.system, onTap: () => onChanged(ThemeMode.system), previewLight: true, isSystem: true),
        const SizedBox(width: 10),
        ThemeCard(icon: Icons.wb_sunny_rounded, label: context.tr('profile.light'), desc: 'Bright', selected: mode == ThemeMode.light, onTap: () => onChanged(ThemeMode.light), previewLight: true),
        const SizedBox(width: 10),
        ThemeCard(icon: Icons.nightlight_round, label: context.tr('profile.dark'), desc: 'Dim', selected: mode == ThemeMode.dark, onTap: () => onChanged(ThemeMode.dark), previewLight: false),
      ],
    );
  }
}

class ThemeCard extends StatelessWidget {
  const ThemeCard({super.key, required this.icon, required this.label, required this.desc, required this.selected, required this.onTap, required this.previewLight, this.isSystem = false});
  final IconData icon;
  final String label;
  final String desc;
  final bool selected;
  final VoidCallback onTap;
  final bool previewLight;
  final bool isSystem;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: AnimatedContainer(
            duration: 240.ms,
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.palette.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: selected ? AppColors.primary : context.palette.border, width: selected ? 2 : 1),
              boxShadow: selected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.14), blurRadius: 16, offset: const Offset(0, 6))] : [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              children: [
                // mini preview
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: previewLight ? const Color(0xFFF8F9FB) : const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.palette.border.withValues(alpha: 0.6)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(top: 8, left: 8, right: 8, child: Container(height: 8, decoration: BoxDecoration(color: previewLight ? Colors.white : const Color(0xFF1F2937), borderRadius: BorderRadius.circular(100), border: Border.all(color: previewLight ? const Color(0xFFE5E7EB) : Colors.transparent)))),
                      Positioned(top: 22, left: 8, right: 28, child: Container(height: 6, decoration: BoxDecoration(color: previewLight ? const Color(0xFFE5E7EB) : const Color(0xFF374151), borderRadius: BorderRadius.circular(100)))),
                      Positioned(top: 32, left: 8, right: 40, child: Container(height: 6, decoration: BoxDecoration(color: previewLight ? const Color(0xFFE5E7EB) : const Color(0xFF374151), borderRadius: BorderRadius.circular(100)))),
                      if (isSystem) Positioned(bottom: 8, right: 8, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle), child: const Icon(Icons.auto_awesome_rounded, size: 10, color: Colors.white))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: selected ? AppColors.primary : AppColors.primary.withValues(alpha: 0.08), shape: BoxShape.circle),
                  child: Icon(icon, size: 16, color: selected ? Colors.white : AppColors.primary),
                ),
                const SizedBox(height: 6),
                Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800, fontSize: 11, color: selected ? AppColors.primary : context.palette.textPrimary)),
                Text(desc, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textMuted, fontSize: 10)),
                if (selected) ...[
                  const SizedBox(height: 6),
                  Container(width: 18, height: 18, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle), child: const Icon(Icons.check_rounded, size: 12, color: Colors.white)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
