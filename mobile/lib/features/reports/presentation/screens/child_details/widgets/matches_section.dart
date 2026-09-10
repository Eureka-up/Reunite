import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/context_extensions.dart';
import '../../../../domain/child_case.dart';
import '../../../../data/repositories/child_case_repository.dart';
import 'match_card.dart';

export 'match_card.dart';

/// Possible-matches section. Card widget lives in `match_card.dart`
/// so this file stays under the 150-line budget. No logic changes.
class MatchesModern extends StatelessWidget {
  const MatchesModern({super.key, required this.matches, required this.caseData});
  final List<PossibleMatch> matches;
  final ChildCase caseData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              context.tr('details.possibleMatches'),
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                '${matches.length}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          context.tr(
            'details.matchCount',
            namedArgs: {'count': '${matches.length}'},
          ),
          style: context.textTheme.bodySmall?.copyWith(
            color: context.palette.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        if (matches.isEmpty)
          const MatchesEmpty()
        else
          ...matches.map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: MatchModernCard(match: m),
            ),
          ),
      ],
    );
  }
}

/// Empty-state box for zero matches, extracted from the section build.
class MatchesEmpty extends StatelessWidget {
  const MatchesEmpty({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.palette.border),
      ),
      child: Row(
        children: [
          Icon(
            Icons.people_outline_rounded,
            color: context.palette.textMuted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.tr('details.notGuaranteed'),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.palette.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
