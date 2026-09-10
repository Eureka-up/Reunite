import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../di/app_di.dart';
import '../storage/stores.dart';

import '../../features/auth/presentation/screens/splash/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/auth/presentation/screens/register/register_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/home/presentation/screens/app_shell/app_shell_screen.dart';
import '../../features/home/presentation/screens/home/home_screen.dart';
import '../../features/missing_children/presentation/screens/missing_children/missing_children_screen.dart';
import '../../features/reports/presentation/screens/child_details/child_details_screen.dart';
import '../../features/reports/presentation/screens/report_missing/report_missing_screen.dart';
import '../../features/reports/presentation/screens/report_found/report_found_screen.dart';
import '../../features/reports/presentation/screens/report_confirmation/report_confirmation_screen.dart';
import '../../features/map/presentation/screens/map/map_screen.dart';
import '../../features/search/presentation/screens/search/search_screen.dart';
import '../../features/notifications/presentation/screens/notifications/notifications_screen.dart';
import '../../features/profile/presentation/screens/profile/profile_screen.dart';
import '../../features/profile/presentation/screens/settings/settings_screen.dart';
import '../../features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/my_reports/my_reports_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: OtpRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(
          page: AppShellRoute.page,
          guards: [AuthGuard()],
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: MissingChildrenRoute.page),
            AutoRoute(page: MapRoute.page),
            AutoRoute(page: NotificationsRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: ChildDetailsRoute.page),
        AutoRoute(page: ReportMissingRoute.page),
        AutoRoute(page: ReportFoundRoute.page),
        AutoRoute(page: ReportConfirmationRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: MyReportsRoute.page),
      ];
}

/// Refreshes the guarded shell routes when auth state changes.
class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final ok = getIt<AuthStore>().isAuthenticated;
    if (ok) {
      resolver.next(true);
    } else {
      router.replaceAll([const OnboardingRoute()]);
      resolver.next(false);
    }
  }
}