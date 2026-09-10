import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/utils/context_extensions.dart';

class ConfirmationTitles extends StatelessWidget {
  const ConfirmationTitles({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.tr('report.confirmationTitle'),
          textAlign: TextAlign.center,
          style: context.textTheme.headlineSmall,
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
        const SizedBox(height: AppDimens.md),
        Text(
          context.tr('report.confirmationSubtitle'),
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.palette.textSecondary,
          ),
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }
}

class CaseIdCard extends StatelessWidget {
  const CaseIdCard({super.key, required this.caseId});
  final String caseId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: context.palette.border),
      ),
      child: Column(
        children: [
          Text(context.tr('report.caseIdLabel'),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.palette.textSecondary,
              )),
          const SizedBox(height: 4),
          Text(caseId, style: context.textTheme.headlineSmall),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}
