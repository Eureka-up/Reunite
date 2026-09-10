import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../shared/domain/app_enums.dart';
import 'section_card.dart';
import 'review_row.dart';

/// Review step, extracted from `missing_view.dart`. No logic changes.
class MissingReviewStep extends StatelessWidget {
  const MissingReviewStep({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.city,
    required this.area,
    required this.clothing,
    required this.phone,
  });
  final String name;
  final String age;
  final Gender? gender;
  final String city;
  final String area;
  final String clothing;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return MissingSectionCard(
      icon: Icons.verified_rounded,
      color: AppColors.primary,
      title: context.tr('report.review'),
      subtitle: context.tr('report.reviewSubtitle'),
      child: Column(children: [
        MissingReviewRow(
            icon: Icons.person_rounded, label: context.tr('report.name'), value: name),
        MissingReviewRow(
            icon: Icons.cake_rounded, label: context.tr('missing.age'), value: age),
        MissingReviewRow(
            icon: Icons.wc_rounded,
            label: context.tr('missing.gender'),
            value: gender == null ? '' : context.tr(gender!.key)),
        MissingReviewRow(
            icon: Icons.location_on_rounded,
            label: context.tr('report.area'),
            value: [city, area].where((e) => e.isNotEmpty).join(' • ')),
        MissingReviewRow(
            icon: Icons.checkroom_rounded,
            label: context.tr('report.clothes'),
            value: clothing),
        MissingReviewRow(
            icon: Icons.phone_rounded,
            label: context.tr('report.contactPhone'),
            value: phone),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            const Icon(Icons.info_outline_rounded,
                size: 16, color: AppColors.warning),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
                    'Please verify all info is accurate before publishing.',
                    style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.warning, fontWeight: FontWeight.w600))),
          ]),
        ),
      ]),
    );
  }
}
