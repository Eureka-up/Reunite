import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/storage/stores.dart';

class OnboardingController extends ChangeNotifier {
  OnboardingController();

  final PageController pages = PageController();
  int page = 0;
  bool finishing = false;

  void onPageChanged(int i) {
    page = i;
    notifyListeners();
  }

  void next() {
    if (page == 2) {
      return;
    }
    pages.nextPage(
      duration: const Duration(milliseconds: 440),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> finish(BuildContext context) async {
    if (finishing) return;
    finishing = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 520));
    final prefs = getIt<PrefsStore>();
    prefs.onboarded = true;
    getIt<AuthStore>().saveGuest();
    if (!context.mounted) return;
    context.router.replaceAll([const LoginRoute()]);
  }

  @override
  void dispose() {
    pages.dispose();
    super.dispose();
  }
}
