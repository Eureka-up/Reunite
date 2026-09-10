/// Notification abstraction, ready for Firebase Cloud Messaging.
///
/// On startup the app registers for push tokens; when a backend is connected
/// the token is sent to the server. These types map 1:1 to FCM data messages.
enum PushType {
  nearbyMissing,
  caseUpdate,
  sighting,
  possibleMatch,
  caseResolved,
}

class PushPayload {
  const PushPayload({
    required this.type,
    required this.title,
    required this.body,
    this.caseId,
    this.metadata = const {},
  });

  final PushType type;
  final String title;
  final String body;
  final String? caseId;
  final Map<String, String> metadata;
}

abstract class PushNotificationService {
  /// Fetches the device registration token.
  Future<String?> getToken();

  /// Displays a local/system push notification.
  Future<void> show(PushPayload payload);

  /// Notifies listeners of an incoming push (background simulation).
  final List<PushPayload> received = [];
}

/// Mock FCM service for the prototype. In production this subscribes to FCM
/// and delegates to the OS notification framework.
class MockPushNotificationService implements PushNotificationService {
  MockPushNotificationService();

  final List<PushPayload> received = [];

  @override
  Future<String?> getToken() async => 'demo-fcm-token';

  @override
  Future<void> show(PushPayload payload) async {
    received.add(payload);
  }
}