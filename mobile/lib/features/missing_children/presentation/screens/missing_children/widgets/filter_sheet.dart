import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../../shared/domain/app_enums.dart';
import '../../../missing_cubit.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key, required this.cubit});
  final MissingCubit cubit;
  @override
  State<FilterSheet> createState() => FilterSheetState();
}

class FilterSheetState extends State<FilterSheet> {
  Gender? _gender;
  bool _activeOnly = false;
  bool _foundOnly = false;
  double _ageRange = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: context.palette.border, borderRadius: BorderRadius.circular(100)))),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.tune_rounded, color: Colors.white, size: 20)),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.tr('missing.filterBy'), style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)), Text('Refine your search', style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary))])),
            Material(color: context.palette.surfaceAlt, borderRadius: BorderRadius.circular(12), child: InkWell(onTap: () => setState(() { _gender = null; _activeOnly = false; _foundOnly = false; }), borderRadius: BorderRadius.circular(12), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Text('Clear', style: context.textTheme.labelSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800))))),
          ],
        ),
        const SizedBox(height: 20),
        Text(context.tr('missing.gender'), style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Row(
          children: [
            SegmentChip(label: context.tr('missing.all'), icon: Icons.people_rounded, selected: _gender == null, onTap: () => setState(() => _gender = null)),
            const SizedBox(width: 8),
            SegmentChip(label: context.tr('missing.male'), icon: Icons.male_rounded, selected: _gender == Gender.male, onTap: () => setState(() => _gender = Gender.male)),
            const SizedBox(width: 8),
            SegmentChip(label: context.tr('missing.female'), icon: Icons.female_rounded, selected: _gender == Gender.female, onTap: () => setState(() => _gender = Gender.female)),
          ],
        ),
        const SizedBox(height: 18),
        Text(context.tr('missing.statusFilter'), style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Row(
          children: [
            SegmentChip(label: context.tr('missing.all'), icon: Icons.layers_rounded, selected: !_activeOnly && !_foundOnly, onTap: () => setState(() { _activeOnly = false; _foundOnly = false; })),
            const SizedBox(width: 8),
            SegmentChip(label: context.tr('status.active'), icon: Icons.circle, selected: _activeOnly, color: AppColors.emergency, onTap: () => setState(() { _activeOnly = true; _foundOnly = false; })),
            const SizedBox(width: 8),
            SegmentChip(label: context.tr('status.found'), icon: Icons.check_circle_rounded, selected: _foundOnly, color: AppColors.success, onTap: () => setState(() { _activeOnly = false; _foundOnly = true; })),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Text('Max age', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
            const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(100)), child: Text('${_ageRange.round()} years', style: context.textTheme.labelSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800))),
          ],
        ),
        Slider(value: _ageRange, min: 0, max: 18, divisions: 18, activeColor: AppColors.primary, inactiveColor: context.palette.surfaceAlt, onChanged: (v) => setState(() => _ageRange = v)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: AppButton(label: context.tr('common.cancel'), outlined: true, onPressed: () => Navigator.pop(context))),
            const SizedBox(width: 12),
            Expanded(child: AppButton(label: 'Apply filters', gradient: AppColors.brandGradient, icon: Icons.check_rounded, onPressed: () { widget.cubit.setGender(_gender); widget.cubit.toggleStatusFilter(activeOnly: _activeOnly, foundOnly: _foundOnly); Navigator.pop(context); })),
          ],
        ),
      ],
    );
  }
}

class SegmentChip extends StatelessWidget {
  const SegmentChip({super.key, required this.label, required this.icon, required this.selected, this.color, required this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final Color c = color ?? AppColors.primary;
    return Expanded(
      child: Material(
        color: selected ? c : context.palette.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 44,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: selected ? c : context.palette.border)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 16, color: selected ? Colors.white : context.palette.textSecondary), const SizedBox(width: 6), Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textTheme.labelMedium?.copyWith(color: selected ? Colors.white : context.palette.textPrimary, fontWeight: FontWeight.w700)))]),
          ),
        ),
      ),
    );
  }
}
