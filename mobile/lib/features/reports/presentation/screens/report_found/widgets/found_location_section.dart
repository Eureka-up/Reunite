import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'section_card.dart';
import 'found_hero.dart';

/// Location section, extracted from `found_view.dart`. No logic changes.
class FoundLocationSection extends StatelessWidget {
  const FoundLocationSection({super.key, required this.foundLocation});
  final TextEditingController foundLocation;

  @override
  Widget build(BuildContext context) {
    return FoundSectionCard(
      icon: Icons.place_rounded,
      color: AppColors.secondary,
      title: context.tr('report.foundLocationSection'),
      subtitle: context.tr('report.foundLocationHint'),
      child: Column(
        children: [
          AppTextField(
              controller: foundLocation,
              icon: Icons.location_on_outlined,
              hint: context.tr('report.foundLocation')),
          const SizedBox(height: 10),
          const FoundLocationHint(),
        ],
      ),
    );
  }
}
