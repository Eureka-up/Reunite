import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Wraps platform connectivity and exposes an app-wide stream.
class ConnectivityService {
  ConnectivityService._();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  bool _online = true;

  static ConnectivityService instance = ConnectivityService._();

  bool get isOnline => _online;

  Stream<bool> get onChanged => _controller.stream;

  void init() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final bool online = results.any(
        (r) => r != ConnectivityResult.none,
      );
      if (online != _online) {
        _online = online;
        _controller.add(online);
      }
    });
    _check();
  }

  Future<void> _check() async {
    final results = await _connectivity.checkConnectivity();
    _online = results.any((r) => r != ConnectivityResult.none);
  }

  void dispose() => _controller.close();
}