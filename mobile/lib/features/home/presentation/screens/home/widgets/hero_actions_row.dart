import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/theme/app_colors.dart';
import 'hero_primary_button.dart';
import 'hero_secondary_button.dart';

class HeroActionsRow extends StatelessWidget {
  const HeroActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HeroPrimaryButton(
            label: context.tr('home.reportMissing'),
            icon: Icons.person_search_rounded,
            gradient: AppColors.emergencyGradient,
            onTap: () => context.router.push(const ReportMissingRoute()),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: HeroSecondaryButton(
            label: context.tr('home.foundChild'),
            icon: Icons.child_friendly_rounded,
            onTap: () => context.router.push(const ReportFoundRoute()),
          ),
        ),
      ],
    );
  }
}
