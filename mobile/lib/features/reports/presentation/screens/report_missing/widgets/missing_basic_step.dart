import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../../shared/domain/app_enums.dart';
import 'section_card.dart';
import 'gender_pill.dart';

/// Basic info step (name/age/gender), extracted from `missing_view.dart`.
class MissingBasicStep extends StatelessWidget {
  const MissingBasicStep({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.onGender,
  });
  final TextEditingController name;
  final TextEditingController age;
  final Gender? gender;
  final ValueChanged<Gender> onGender;

  @override
  Widget build(BuildContext context) {
    return MissingSectionCard(
      icon: Icons.person_rounded,
      color: AppColors.info,
      title: context.tr('report.basicInfo'),
      subtitle: 'Name, age and gender',
      child: Column(
        children: [
          AppTextField(
              controller: name,
              icon: Icons.person_outline_rounded,
              hint: context.tr('report.name')),
          const SizedBox(height: 14),
          AppTextField(
              controller: age,
              icon: Icons.cake_outlined,
              hint: context.tr('missing.age'),
              keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(context.tr('missing.gender'),
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700))),
          const SizedBox(height: 10),
          Row(
            children: [
              MissingGenderPill(
                  label: context.tr('missing.male'),
                  icon: Icons.male_rounded,
                  selected: gender == Gender.male,
                  onTap: () => onGender(Gender.male)),
              const SizedBox(width: 10),
              MissingGenderPill(
                  label: context.tr('missing.female'),
                  icon: Icons.female_rounded,
                  selected: gender == Gender.female,
                  onTap: () => onGender(Gender.female)),
            ],
          ),
        ],
      ),
    );
  }
}
