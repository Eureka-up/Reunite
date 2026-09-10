import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'section_card.dart';

/// Contact step, extracted from `missing_view.dart`. No logic changes.
class MissingContactStep extends StatelessWidget {
  const MissingContactStep({super.key, required this.phone, required this.email});
  final TextEditingController phone;
  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return MissingSectionCard(
      icon: Icons.call_rounded,
      color: AppColors.success,
      title: context.tr('report.contactInfo'),
      subtitle: 'How we can reach you',
      child: Column(children: [
        AppTextField(
            controller: phone,
            icon: Icons.phone_rounded,
            hint: context.tr('report.contactPhone'),
            keyboardType: TextInputType.phone),
        const SizedBox(height: 12),
        AppTextField(
            controller: email,
            icon: Icons.alternate_email_rounded,
            hint: context.tr('report.contactEmail'),
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.info.withValues(alpha: 0.08),
                AppColors.primary.withValues(alpha: 0.06)
              ]),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.14))),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: AppColors.info.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.shield_rounded,
                        size: 18, color: AppColors.info)),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('Privacy protected',
                          style: context.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(context.tr('details.contactDialogSub'),
                          style: context.textTheme.bodySmall?.copyWith(
                              color: context.palette.textSecondary, height: 1.4)),
                    ])),
              ]),
        ),
      ]),
    );
  }
}
