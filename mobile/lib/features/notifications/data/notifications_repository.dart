import '../../shared/domain/app_enums.dart';
import '../../notifications/domain/app_notification.dart';

/// Notifications repository abstraction.
abstract class NotificationsRepository {
  Future<List<AppNotification>> getAll();

  Future<void> markAllRead();
}

class MockNotificationsRepository implements NotificationsRepository {
  MockNotificationsRepository();

  final List<AppNotification> _items = [
    AppNotification(
      id: 'n1',
      type: AppNotificationType.emergency,
      titleKey: 'notif.nearbyTitle',
      bodyKey: 'notif.nearbyBody',
      createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
      caseId: 'RC-1001',
    ),
    AppNotification(
      id: 'n2',
      type: AppNotificationType.caseUpdate,
      titleKey: 'notif.updateTitle',
      bodyKey: 'notif.updateBody',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      caseId: 'RC-1004',
      read: true,
    ),
    AppNotification(
      id: 'n3',
      type: AppNotificationType.possibleMatch,
      titleKey: 'notif.matchTitle',
      bodyKey: 'notif.matchBody',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      caseId: 'RC-1001',
    ),
    AppNotification(
      id: 'n4',
      type: AppNotificationType.success,
      titleKey: 'notif.successTitle',
      bodyKey: 'notif.successBody',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      caseId: 'RC-0900',
      read: true,
    ),
    AppNotification(
      id: 'n5',
      type: AppNotificationType.emergency,
      titleKey: 'notif.nearbyTitle',
      bodyKey: 'notif.nearbyBody',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      caseId: 'RC-1002',
      namedArgs: {'place': 'مصر الجديدة'},
      read: true,
    ),
  ];

  @override
  Future<List<AppNotification>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.of(_items);
  }

  @override
  Future<void> markAllRead() async {
    await Future.delayed(const Duration(milliseconds: 200));
    for (var i = 0; i < _items.length; i++) {
      _items[i] = _items[i].copyWith(read: true);
    }
  }
}