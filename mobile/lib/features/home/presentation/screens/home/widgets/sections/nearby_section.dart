import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../../core/router/app_router.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_dimens.dart';
import '../../../../../../../core/widgets/widgets.dart';
import '../../../../../../../features/reports/domain/child_case.dart';
import '../modern_empty.dart';
import '../modern_section_header.dart';

class NearbySection extends StatelessWidget {
  const NearbySection({super.key, required this.nearby, required this.hasLocation});
  final List<ChildCase> nearby;
  final bool hasLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
          child: ModernSectionHeader(
            icon: Icons.near_me_rounded,
            iconBg: AppColors.info,
            title: context.tr('home.nearbyAlerts'),
            subtitle: hasLocation ? context.tr('home.within10km') : context.tr('home.enableLocation'),
          ),
        ),
        const SizedBox(height: 14),
        if (nearby.isEmpty)
          ModernEmpty(
            title: context.tr('home.emptyNearby'),
            subtitle: context.tr('home.emptyNearbySub'),
            icon: Icons.notifications_off_outlined,
            color: AppColors.info,
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
            child: Column(
              children: List.generate(nearby.length, (i) {
                final c = nearby[i];
                return Padding(
                  padding: EdgeInsets.only(bottom: i == nearby.length - 1 ? 0 : 12),
                  child: ChildCaseCard(
                    caseData: c,
                    onTap: () => context.router.push(ChildDetailsRoute(caseId: c.id)),
                  ).animate().fadeIn(delay: (200 + i * 60).ms).slideY(begin: 0.08),
                );
              }),
            ),
          ),
      ],
    );
  }
}



