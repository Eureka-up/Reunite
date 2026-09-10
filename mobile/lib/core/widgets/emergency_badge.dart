import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../theme/app_colors.dart';
import '../utils/context_extensions.dart';
import '../../features/shared/domain/app_enums.dart';

/// Minimal urgency dot — kept for optional use elsewhere, NOT shown in cards now
class EmergencyBadge extends StatelessWidget {
  const EmergencyBadge({super.key, required this.level, this.compact = false});
  final UrgencyLevel level;
  final bool compact;
  @override
  Widget build(BuildContext context) {
    final (Color color, String label) = switch (level) {
      UrgencyLevel.high => (AppColors.emergency, context.tr('urgency.high')),
      UrgencyLevel.medium => (AppColors.warning, context.tr('urgency.medium')),
      UrgencyLevel.low => (AppColors.info, context.tr('urgency.low')),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 7 : 9, vertical: compact ? 3 : 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.09), borderRadius: BorderRadius.circular(100)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: context.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700, fontSize: compact ? 11 : 11.5)),
      ]),
    );
  }
}
