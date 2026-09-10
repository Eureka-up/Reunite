import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_dimens.dart';
import '../../../../../../../features/reports/data/repositories/child_case_repository.dart';
import '../modern_section_header.dart';
import '../stat_bento_card.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key, required this.stats});
  final CaseStatistics stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
          child: ModernSectionHeader(
            icon: Icons.bar_chart_rounded,
            title: context.tr('home.statistics'),
            subtitle: context.tr('home.liveImpact'),
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatBentoCard(
                      value: stats.activeCases,
                      label: context.tr('home.statActive'),
                      subLabel: context.tr('home.statSubToday'),
                      icon: Icons.access_time_rounded,
                      gradient: AppColors.emergencyGradient,
                      bg: AppColors.emergencySoft,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatBentoCard(
                      value: stats.childrenFound,
                      label: context.tr('home.statFound'),
                      subLabel: context.tr('home.statSubMonth'),
                      icon: Icons.people_alt_rounded,
                      gradient: AppColors.successGradient,
                      bg: AppColors.successSoft,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatBentoCard(
                      value: stats.reportsToday,
                      label: context.tr('home.statToday'),
                      subLabel: context.tr('home.statVerified'),
                      icon: Icons.edit_note_rounded,
                      gradient: AppColors.coolGradient,
                      bg: AppColors.infoSoft,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatBentoCard(
                      value: stats.reunifications,
                      label: context.tr('home.statReunited'),
                      subLabel: context.tr('home.statAllTime'),
                      icon: Icons.favorite_rounded,
                      gradient: AppColors.warmGradient,
                      bg: AppColors.accent.withValues(alpha: 0.14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(delay: 160.ms).slideY(begin: 0.06),
      ],
    );
  }
}



