import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'section_card.dart';

/// Appearance step, extracted from `missing_view.dart`. No logic changes.
class MissingAppearanceStep extends StatelessWidget {
  const MissingAppearanceStep({
    super.key,
    required this.clothing,
    required this.marks,
    required this.description,
  });
  final TextEditingController clothing;
  final TextEditingController marks;
  final TextEditingController description;

  @override
  Widget build(BuildContext context) {
    return MissingSectionCard(
      icon: Icons.visibility_rounded,
      color: AppColors.accent,
      title: context.tr('report.appearance'),
      subtitle: 'Clothing, marks and description',
      child: Column(children: [
        AppTextField(
            controller: clothing,
            icon: Icons.checkroom_outlined,
            hint: context.tr('report.clothes'),
            maxLines: 2),
        const SizedBox(height: 12),
        AppTextField(
            controller: marks,
            icon: Icons.remove_red_eye_outlined,
            hint: context.tr('report.distinguishing')),
        const SizedBox(height: 12),
        AppTextField(
            controller: description,
            icon: Icons.notes_rounded,
            hint: context.tr('report.desc'),
            maxLines: 4),
      ]),
    );
  }
}
