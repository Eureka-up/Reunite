import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'section_card.dart';

/// Appearance section, extracted from `found_view.dart`. No logic changes.
class FoundAppearanceSection extends StatelessWidget {
  const FoundAppearanceSection({
    super.key,
    required this.clothing,
    required this.description,
    required this.extra,
  });
  final TextEditingController clothing;
  final TextEditingController description;
  final TextEditingController extra;

  @override
  Widget build(BuildContext context) {
    return FoundSectionCard(
      icon: Icons.visibility_rounded,
      color: AppColors.accent,
      title: context.tr('report.foundAppearanceSection'),
      subtitle: context.tr('report.foundAppearanceSub'),
      child: Column(children: [
        AppTextField(
            controller: clothing,
            icon: Icons.checkroom_outlined,
            hint: context.tr('report.clothes'),
            maxLines: 2),
        const SizedBox(height: 12),
        AppTextField(
            controller: description,
            icon: Icons.notes_rounded,
            hint: context.tr('report.desc'),
            maxLines: 3),
        const SizedBox(height: 12),
        AppTextField(
            controller: extra,
            icon: Icons.info_outline_rounded,
            hint: context.tr('report.extraInfo'),
            maxLines: 2),
      ]),
    );
  }
}
