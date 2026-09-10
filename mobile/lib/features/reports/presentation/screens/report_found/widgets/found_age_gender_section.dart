import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../../shared/domain/app_enums.dart';
import 'section_card.dart';
import 'gender_pill.dart';

/// Age + gender section, extracted from `found_view.dart`.
class FoundAgeGenderSection extends StatelessWidget {
  const FoundAgeGenderSection({
    super.key,
    required this.age,
    required this.gender,
    required this.onGender,
  });
  final TextEditingController age;
  final Gender? gender;
  final ValueChanged<Gender> onGender;

  @override
  Widget build(BuildContext context) {
    return FoundSectionCard(
      icon: Icons.cake_rounded,
      color: AppColors.info,
      title: context.tr('report.foundAgeGender'),
      subtitle: context.tr('report.foundAgeGenderSub'),
      child: Column(
        children: [
          AppTextField(
              controller: age,
              icon: Icons.tag_rounded,
              hint: context.tr('report.estimatedAge'),
              keyboardType: TextInputType.number),
          const SizedBox(height: 14),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(context.tr('missing.gender'),
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 13))),
          const SizedBox(height: 10),
          Row(children: [
            FoundGenderPill(
                label: context.tr('missing.male'),
                icon: Icons.male_rounded,
                selected: gender == Gender.male,
                onTap: () => onGender(Gender.male)),
            const SizedBox(width: 10),
            FoundGenderPill(
                label: context.tr('missing.female'),
                icon: Icons.female_rounded,
                selected: gender == Gender.female,
                onTap: () => onGender(Gender.female)),
          ]),
        ],
      ),
    );
  }
}
