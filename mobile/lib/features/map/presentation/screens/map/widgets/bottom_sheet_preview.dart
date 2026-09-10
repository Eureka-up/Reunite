import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../reports/domain/child_case.dart';

class BottomSheetPreview extends StatelessWidget {
  const BottomSheetPreview({super.key, required this.cases});

  final List<ChildCase> cases;

  @override
  Widget build(BuildContext context) {
    final visible = cases.take(3).toList();
    return Container(
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: context.palette.cardShadow, blurRadius: 16, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.palette.border,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const SizedBox(height: AppDimens.md),
              Text(context.tr('map.preview'),
                  style: context.textTheme.titleMedium),
              const SizedBox(height: AppDimens.md),
              ...visible.map(
                (c) => InkWell(
                  onTap: () =>
                      context.router.push(ChildDetailsRoute(caseId: c.id)),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppColors.emergency,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppDimens.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.name, style: context.textTheme.titleSmall),
                              Text(
                                c.area,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.palette.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
