import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../../reports/domain/child_case.dart';
import '../../../../../reports/presentation/widgets/case_timeline.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report});

  final ChildCase report;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.lg),
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(color: context.palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(report.name, style: context.textTheme.titleMedium),
              ),
              StatusBadge(status: report.status, verified: report.verified),
            ],
          ),
          const SizedBox(height: AppDimens.md),
          Text(context.tr('myReports.timeline'),
              style: context.textTheme.labelMedium?.copyWith(
                color: context.palette.textSecondary,
              )),
          const SizedBox(height: AppDimens.md),
          CaseTimeline(status: report.status),
        ],
      ),
    );
  }
}
