import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/date_formats.dart';
import '../../../../domain/app_notification.dart';
import '../../../notifications_cubit.dart';
import 'filter_bar.dart';
import 'hero_header.dart';
import 'notification_card.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key, required this.items});
  final List<AppNotification> items;
  @override
  State<NotificationsList> createState() => NotificationsListState();
}

class NotificationsListState extends State<NotificationsList> {
  String _seg = 'all'; // all | unread

  @override
  Widget build(BuildContext context) {
    final all = widget.items;
    final unreadCount = all.where((e) => !e.read).length;
    final emergencyCount = all.where((e) => e.isEmergency).length;

    final filtered = all.where((n) {
      if (_seg == 'unread') return !n.read;
      return true;
    }).toList();

    // group by day
    final Map<String, List<AppNotification>> groups = {};
    for (final n in filtered) {
      final k = _dayLabel(n.createdAt);
      groups.putIfAbsent(k, () => []).add(n);
    }

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        // ── Hero header ──
        SliverToBoxAdapter(
          child: HeroHeader(
            total: all.length,
            unread: unreadCount,
            emergency: emergencyCount,
            onMarkAll: unreadCount > 0 ? () => context.read<NotificationsCubit>().markAllRead() : null,
          ),
        ),
        // ── Segmented filter — sticky ──
        SliverPersistentHeader(
          pinned: true,
          delegate: NotificationsFilterDelegate(
            seg: _seg,
            all: all.length,
            unread: unreadCount,
            emergency: emergencyCount,
            onChange: (v) => setState(() => _seg = v),
          ),
        ),
        // ── Timeline groups ──
        if (filtered.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: InlineEmpty(seg: _seg),
            ),
          )
        else
          for (final entry in groups.entries) ...[
            SliverToBoxAdapter(
              child: DateHeader(label: entry.key, count: entry.value.length),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              sliver: SliverList.builder(
                itemCount: entry.value.length,
                itemBuilder: (context, i) {
                  final n = entry.value[i];
                  final isLast = i == entry.value.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 16 : 12),
                    child: VeryModernCard(notification: n, index: i)
                        .animate()
                        .fadeIn(delay: (i * 45).ms, duration: 340.ms)
                        .slideY(begin: 0.06, duration: 340.ms),
                  );
                },
              ),
            ),
          ],
        const SliverToBoxAdapter(child: SizedBox(height: 110)),
      ],
    );
  }

  String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final a = DateTime(now.year, now.month, now.day);
    final b = DateTime(d.year, d.month, d.day);
    final diff = a.difference(b).inDays;
    if (diff == 0) return context.tr('notifications.today');
    if (diff == 1) return context.tr('notifications.yesterday');
    if (diff < 7) return DateFormat('EEEE', context.locale.languageCode).format(d);
    return DateFormats.compact(d);
  }
}
