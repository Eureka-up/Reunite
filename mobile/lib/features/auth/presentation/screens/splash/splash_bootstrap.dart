import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/storage/stores.dart';

Future<void> bootstrapSplash(BuildContext context) async {
  await Future<void>.delayed(const Duration(seconds: 4));
  if (!context.mounted) return;
  final auth = getIt<AuthStore>();
  final prefs = getIt<PrefsStore>();
  if (!prefs.onboarded) {
    context.router.replaceAll([const OnboardingRoute()]);
  } else if (auth.isAuthenticated) {
    context.router.replaceAll([const AppShellRoute()]);
  } else {
    context.router.replaceAll([const LoginRoute()]);
  }
}
