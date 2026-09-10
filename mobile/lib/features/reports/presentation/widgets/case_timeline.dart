import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../shared/domain/app_enums.dart';

/// Animated timeline of case statuses.
class CaseTimeline extends StatelessWidget {
  const CaseTimeline({super.key, required this.status});

  final CaseStatus status;

  static const List<CaseStatus> _ordered = [
    CaseStatus.reported,
    CaseStatus.underReview,
    CaseStatus.published,
    CaseStatus.possibleSighting,
    CaseStatus.childFound,
    CaseStatus.caseClosed,
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = _ordered.indexOf(status);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < _ordered.length; i++)
          _step(
            context,
            index: i,
            reached: i <= currentIndex,
            isCurrent: i == currentIndex,
          ),
      ],
    );
  }

  Widget _step(BuildContext context, {required int index, required bool reached, required bool isCurrent}) {
    final CaseStatus s = _ordered[index];
    final Color activeColor = isCurrent
        ? AppColors.secondary
        : reached
            ? AppColors.success
            : context.palette.border;
    final bool last = index == _ordered.length - 1;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Transform.scale(
                scale: isCurrent ? 1.15 : 1.0,
                child: AnimatedContainer(
                  duration: 400.ms,
                  curve: Curves.easeOut,
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.palette.surface, width: 2),
                    boxShadow: reached
                        ? [BoxShadow(color: activeColor.withValues(alpha: 0.35), blurRadius: 8)]
                        : null,
                  ),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: reached ? AppColors.success.withValues(alpha: 0.5) : context.palette.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      context.tr(s.key),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: reached ? context.palette.textPrimary : context.palette.textMuted,
                      ),
                    ),
                  ),
                  if (isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(Icons.timelapse, size: 12, color: AppColors.secondary),
                    ),
                ],
              ).animate(target: reached ? 1 : 0)
                  .fade(begin: 0.4)
                  .slideX(begin: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}