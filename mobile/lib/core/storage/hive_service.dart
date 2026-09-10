import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

/// Owns the Hive boxes used across the app.
/// Boxes are opened once at startup and exposed via [GetIt]-managed services.
class HiveService {
  HiveService._();

  static late Box _authBox;
  static late Box _prefsBox;
  static late Box _cacheBox;

  static Box get authBox => _authBox;
  static Box get prefsBox => _prefsBox;
  static Box get cacheBox => _cacheBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _authBox = await Hive.openBox(AppConstants.hiveAuthBox);
    _prefsBox = await Hive.openBox(AppConstants.hivePrefsBox);
    _cacheBox = await Hive.openBox(AppConstants.hiveCacheBox);
  }
}