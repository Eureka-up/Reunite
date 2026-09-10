import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../missing_cubit.dart';
import 'filter_sheet.dart';

class FilterActionPill extends StatelessWidget {
  const FilterActionPill({super.key, required this.cubit});
  final MissingCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: () => showAppBottomSheet<void>(context, child: FilterSheet(cubit: cubit)),
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.tune_rounded, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(context.tr('missing.filters'), style: context.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}
