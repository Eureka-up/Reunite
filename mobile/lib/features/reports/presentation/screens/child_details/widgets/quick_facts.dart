import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../domain/child_case.dart';
import 'details_utils.dart';

class QuickFacts extends StatelessWidget {
  const QuickFacts({super.key, required this.caseData});
  final ChildCase caseData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Fact(
          icon: Icons.schedule_rounded,
          label: 'Missing',
          value: detailsDateTimeLabel(caseData.missingSince).split(' ').first,
          color: AppColors.warning,
        ),
        const SizedBox(width: 10),
        Fact(
          icon: Icons.location_on_rounded,
          label: 'Area',
          value: caseData.area.split(' ').first,
          color: AppColors.info,
        ),
        const SizedBox(width: 10),
        Fact(
          icon: Icons.people_rounded,
          label: 'Age',
          value: '${caseData.age} yrs',
          color: AppColors.primary,
        ),
      ],
    );
  }
}

class Fact extends StatelessWidget {
  const Fact({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: context.palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.palette.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 6),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.palette.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
