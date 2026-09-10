import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/utils/context_extensions.dart';

class InlineEmpty extends StatelessWidget {
  const InlineEmpty({super.key, required this.seg});
  final String seg;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: context.palette.border)),
      child: Column(children: [
        Container(width: 56, height: 56, decoration: BoxDecoration(color: context.palette.surfaceAlt, borderRadius: BorderRadius.circular(16)), child: Icon(seg == 'unread' ? Icons.mark_email_read_rounded : Icons.notifications_none_rounded, color: context.palette.textMuted, size: 28)),
        const SizedBox(height: 12),
        Text(seg == 'unread' ? context.tr('notifications.noUnread') : context.tr('notifications.empty'), style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(context.tr('notifications.allCaughtUp'), style: context.textTheme.bodySmall?.copyWith(color: context.palette.textSecondary)),
      ]),
    );
  }
}
