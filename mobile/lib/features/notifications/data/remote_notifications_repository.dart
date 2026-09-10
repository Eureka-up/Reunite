import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../domain/app_notification.dart';
import 'notifications_repository.dart';

List<AppNotification> _parseList(dynamic data) {
  final List items;
  if (data is List) {
    items = data;
  } else if (data is Map<String, dynamic>) {
    final inner = data['data'];
    if (inner is List) {
      items = inner;
    } else if (inner is Map && inner['notifications'] is List) {
      items = inner['notifications'] as List;
    } else if (data['notifications'] is List) {
      items = data['notifications'] as List;
    } else {
      items = const [];
    }
  } else {
    items = const [];
  }
  return items
      .whereType<Map<String, dynamic>>()
      .map(AppNotification.fromJson)
      .toList();
}

/// REST-backed notifications. Drop-in replacement for
/// [MockNotificationsRepository].
class RemoteNotificationsRepository implements NotificationsRepository {
  RemoteNotificationsRepository(this._api);

  final ApiClient _api;

  @override
  Future<List<AppNotification>> getAll() async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.notifications));
    return _parseList(res.data);
  }

  @override
  Future<void> markAllRead() async {
    await _api.run((dio) => dio.post(ApiEndpoints.notificationsReadAll));
  }
}
