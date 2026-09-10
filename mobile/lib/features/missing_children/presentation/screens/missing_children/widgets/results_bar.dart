import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../missing_cubit.dart';
import 'toggle_icon.dart';

class ResultsBar extends StatelessWidget {
  const ResultsBar({super.key, required this.count, required this.isGrid, required this.onToggleView, required this.cubit});
  final int count;
  final bool isGrid;
  final VoidCallback onToggleView;
  final MissingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppDimens.xl, 8, AppDimens.xl, 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: context.palette.surfaceAlt, borderRadius: BorderRadius.circular(100)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.layers_rounded, size: 14, color: context.palette.textSecondary),
                const SizedBox(width: 6),
                Text('$count ${context.tr('missing.title').toLowerCase()}', style: context.textTheme.labelSmall?.copyWith(color: context.palette.textSecondary, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(color: context.palette.surfaceAlt, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ToggleIcon(icon: Icons.view_list_rounded, selected: !isGrid, onTap: onToggleView),
                ToggleIcon(icon: Icons.grid_view_rounded, selected: isGrid, onTap: onToggleView),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
