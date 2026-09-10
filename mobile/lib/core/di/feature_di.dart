import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/data/remote_auth_repository.dart';
import '../../features/notifications/data/notifications_repository.dart';
import '../../features/notifications/data/remote_notifications_repository.dart';
import '../../features/reports/data/repositories/child_case_repository.dart';
import '../../features/reports/data/repositories/remote_child_case_repository.dart';
import '../locations/locations_repository.dart';
import '../locations/mock_locations_repository.dart';
import '../locations/remote_locations_repository.dart';
import '../network/api_client.dart';
import '../network/api_config.dart';
import '../storage/stores.dart';

/// Initializes repositories and features in the DI container.
///
/// When [kUseMock] is true (default) all repositories are in-memory mocks
/// so the app works offline. Run with `--dart-define=USE_MOCK=false`
/// to use the REST implementations backed by [ApiClient]:
/// ```
/// flutter run --dart-define=USE_MOCK=false
/// ```
Future<void> initFeatureDependencies() async {
  final GetIt di = GetIt.instance;

  if (kUseMock) {
    final childCaseRepo = MockChildCaseRepository();
    di.registerLazySingleton<ChildCaseRepository>(() => childCaseRepo);
    di.registerLazySingleton<ReportsRepository>(() => childCaseRepo);
    di.registerLazySingleton<AuthRepository>(() => MockAuthRepository());
    di.registerLazySingleton<NotificationsRepository>(
      () => MockNotificationsRepository(),
    );
    di.registerLazySingleton<LocationsRepository>(
      () => const MockLocationsRepository(),
    );
  } else {
    final ApiClient api = di<ApiClient>();
    final AuthStore authStore = di<AuthStore>();
    final remoteCases = RemoteChildCaseRepository(api);
    di.registerLazySingleton<ChildCaseRepository>(() => remoteCases);
    di.registerLazySingleton<ReportsRepository>(() => remoteCases);
    di.registerLazySingleton<AuthRepository>(
      () => RemoteAuthRepository(api, authStore),
    );
    di.registerLazySingleton<NotificationsRepository>(
      () => RemoteNotificationsRepository(api),
    );
    di.registerLazySingleton<LocationsRepository>(
      () => RemoteLocationsRepository(api),
    );
  }
}