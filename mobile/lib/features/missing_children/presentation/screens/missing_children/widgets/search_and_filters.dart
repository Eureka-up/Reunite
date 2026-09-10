import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../shared/domain/app_enums.dart';
import '../../../missing_cubit.dart';
import 'filter_action_pill.dart';
import 'filter_pill.dart';
import 'sort_pill.dart';

class SearchAndFilters extends StatelessWidget {
  const SearchAndFilters({super.key, required this.controller, required this.onSearch, required this.cubit});
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final MissingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppDimens.xl, 12, AppDimens.xl, 12),
        child: Column(
          children: [
            _SearchBar(controller: controller, onSearch: onSearch),
            const SizedBox(height: 12),
            _FilterChipsRow(cubit: cubit),
            const SizedBox(height: 8),
            _QuickActionsRow(controller: controller, cubit: cubit),
          ],
        ),
      ).animate().fadeIn(duration: 320.ms).slideY(begin: 0.06),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller, required this.onSearch});
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.palette.border),
        boxShadow: [BoxShadow(color: context.palette.cardShadow, blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(11)),
            child: Icon(Icons.search_rounded, size: 20, color: context.colorScheme.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onSearch,
              style: context.textTheme.bodyMedium?.copyWith(color: context.palette.textPrimary),
              decoration: InputDecoration(
                hintText: context.tr('missing.searchHint'),
                hintStyle: context.textTheme.bodyMedium?.copyWith(color: context.palette.textMuted),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              color: context.palette.textMuted,
              onPressed: () {
                controller.clear();
                onSearch('');
              },
            )
          else
            const SizedBox(width: 8),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _FilterChipsRow extends StatelessWidget {
  const _FilterChipsRow({required this.cubit});
  final MissingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterPill(label: context.tr('missing.all'), selected: true, icon: Icons.apps_rounded, onTap: () => cubit.clearFilters()),
          const SizedBox(width: 8),
          FilterPill(label: context.tr('missing.male'), icon: Icons.male_rounded, selected: false, onTap: () => cubit.setGender(Gender.male)),
          const SizedBox(width: 8),
          FilterPill(label: context.tr('missing.female'), icon: Icons.female_rounded, selected: false, onTap: () => cubit.setGender(Gender.female)),
          const SizedBox(width: 8),
          FilterPill(label: context.tr('home.filterNearby'), icon: Icons.near_me_rounded, onTap: () {}),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow({required this.controller, required this.cubit});
  final TextEditingController controller;
  final MissingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SortPill(cubit: cubit),
        const SizedBox(width: 8),
        FilterActionPill(cubit: cubit),
        const Spacer(),
        Expanded(
          child: Text(
            '${context.tr('missing.filters')} • ${controller.text.isEmpty ? context.tr('missing.all') : controller.text}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: context.textTheme.labelSmall?.copyWith(color: context.palette.textMuted),
          ),
        ),
      ],
    );
  }
}
