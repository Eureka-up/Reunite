import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/utils/context_extensions.dart';
import '../../../missing_cubit.dart';

class SortPill extends StatelessWidget {
  const SortPill({super.key, required this.cubit});
  final MissingCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.palette.surface,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: () => cubit.toggleSort(true),
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: context.palette.border)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.swap_vert_rounded, size: 16, color: context.palette.textSecondary),
              const SizedBox(width: 6),
              Text(context.tr('missing.newest'), style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
