import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import 'filter_chip.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key, required this.onSearchTap});
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppDimens.xl, 0, AppDimens.xl, AppDimens.xl),
      child: Column(
        children: [
          // Premium search bar with shadow + action
          Container(
            height: 58,
            decoration: BoxDecoration(
              color: context.palette.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: context.palette.border),
              boxShadow: [
                BoxShadow(color: context.palette.cardShadow, blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSearchTap,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          gradient: AppColors.brandGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.search_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.tr('home.searchHint'),
                          style: context.textTheme.bodyMedium?.copyWith(color: context.palette.textMuted),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: context.palette.surfaceAlt,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.tune_rounded, size: 16, color: context.palette.textSecondary),
                            const SizedBox(width: 4),
                            Text(context.tr('missing.filters'), style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Quick filter chips — urgent removed
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeFilterChip(label: context.tr('home.filterAllCases'), icon: Icons.apps_rounded, selected: true),
                const SizedBox(width: 8),
                HomeFilterChip(label: context.tr('home.filterNearby'), icon: Icons.near_me_rounded, selected: false),
                const SizedBox(width: 8),
                HomeFilterChip(label: context.tr('home.filterToday'), icon: Icons.today_rounded, selected: false),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 120.ms, duration: 400.ms).slideY(begin: 0.06);
  }
}
