import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'section_card.dart';

/// Date + location step, extracted from `missing_view.dart`.
class MissingDateStep extends StatelessWidget {
  const MissingDateStep({
    super.key,
    required this.missingDate,
    required this.dateLabel,
    required this.onPickDate,
    required this.lastLocation,
    required this.city,
    required this.area,
  });
  final DateTime missingDate;
  final String dateLabel;
  final VoidCallback onPickDate;
  final TextEditingController lastLocation;
  final TextEditingController city;
  final TextEditingController area;

  @override
  Widget build(BuildContext context) {
    return MissingSectionCard(
      icon: Icons.event_rounded,
      color: AppColors.secondary,
      title: context.tr('report.missingDate'),
      subtitle: 'When and where',
      child: Column(
        children: [
          Material(
            color: context.palette.surfaceAlt.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onPickDate,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: context.palette.border)),
                child: Row(children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color:
                              AppColors.secondary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.calendar_today_rounded,
                          size: 18, color: AppColors.secondary)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(context.tr('report.missingDate'),
                            style: context.textTheme.labelSmall?.copyWith(
                                color: context.palette.textSecondary,
                                fontWeight: FontWeight.w600)),
                        Text(dateLabel,
                            style: context.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700)),
                      ])),
                  Icon(Icons.chevron_right_rounded,
                      color: context.palette.textMuted),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 14),
          AppTextField(
              controller: lastLocation,
              icon: Icons.place_outlined,
              hint: context.tr('report.lastLocation')),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: AppTextField(
                    controller: city,
                    icon: Icons.location_city_rounded,
                    hint: context.tr('report.city'))),
            const SizedBox(width: 10),
            Expanded(
                child: AppTextField(
                    controller: area,
                    icon: Icons.my_location_rounded,
                    hint: context.tr('report.area'))),
          ]),
        ],
      ),
    );
  }
}
