import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../theme/app_colors.dart';
import '../utils/context_extensions.dart';
import '../../features/shared/domain/app_enums.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, this.verified = false});
  final CaseStatus status;
  final bool verified;
  @override
  Widget build(BuildContext context) {
    final (Color color, IconData icon) = switch (status) {
      CaseStatus.reported || CaseStatus.underReview => (AppColors.warning, Icons.hourglass_top_rounded),
      CaseStatus.published => (context.palette.textMuted, Icons.circle),
      CaseStatus.possibleSighting => (AppColors.info, Icons.visibility_outlined),
      CaseStatus.childFound || CaseStatus.caseClosed => (AppColors.success, Icons.check_circle_outline_rounded),
    };
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: color),
      const SizedBox(width: 4),
      Text(context.tr(status.key), style: context.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w600, fontSize: 11)),
    ]);
  }
}
