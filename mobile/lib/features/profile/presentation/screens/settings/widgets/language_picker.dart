import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';

class LanguageGrid extends StatelessWidget {
  const LanguageGrid({super.key, required this.current, required this.onChanged});
  final Locale current;
  final ValueChanged<Locale> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LangCard(flag: '🇸🇦', name: 'العربية', sub: 'Arabic', selected: current.languageCode == 'ar', onTap: () => onChanged(const Locale('ar'))),
        const SizedBox(width: 10),
        LangCard(flag: '🇺🇸', name: 'English', sub: 'English', selected: current.languageCode == 'en', onTap: () => onChanged(const Locale('en'))),
      ],
    );
  }
}

class LangCard extends StatelessWidget {
  const LangCard({super.key, required this.flag, required this.name, required this.sub, required this.selected, required this.onTap});
  final String flag;
  final String name;
  final String sub;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: AnimatedContainer(
            duration: 230.ms,
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            decoration: BoxDecoration(
              color: context.palette.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: selected ? AppColors.primary : context.palette.border, width: selected ? 2 : 1),
              boxShadow: selected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.12), blurRadius: 14, offset: const Offset(0, 6))] : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(flag, style: const TextStyle(fontSize: 26)),
                    const Spacer(),
                    AnimatedContainer(
                      duration: 200.ms,
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(color: selected ? AppColors.primary : Colors.transparent, shape: BoxShape.circle, border: Border.all(color: selected ? AppColors.primary : context.palette.border, width: 1.6)),
                      child: selected ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(name, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, fontSize: 14, color: selected ? AppColors.primary : context.palette.textPrimary)),
                Text(sub, style: context.textTheme.labelSmall?.copyWith(color: context.palette.textMuted, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
