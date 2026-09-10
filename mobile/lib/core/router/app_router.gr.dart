// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppShellScreen]
class AppShellRoute extends PageRouteInfo<void> {
  const AppShellRoute({List<PageRouteInfo>? children})
    : super(AppShellRoute.name, initialChildren: children);

  static const String name = 'AppShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppShellScreen();
    },
  );
}

/// generated route for
/// [ChildDetailsScreen]
class ChildDetailsRoute extends PageRouteInfo<ChildDetailsRouteArgs> {
  ChildDetailsRoute({
    Key? key,
    required String caseId,
    List<PageRouteInfo>? children,
  }) : super(
         ChildDetailsRoute.name,
         args: ChildDetailsRouteArgs(key: key, caseId: caseId),
         initialChildren: children,
       );

  static const String name = 'ChildDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChildDetailsRouteArgs>();
      return ChildDetailsScreen(key: args.key, caseId: args.caseId);
    },
  );
}

class ChildDetailsRouteArgs {
  const ChildDetailsRouteArgs({this.key, required this.caseId});

  final Key? key;

  final String caseId;

  @override
  String toString() {
    return 'ChildDetailsRouteArgs{key: $key, caseId: $caseId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChildDetailsRouteArgs) return false;
    return key == other.key && caseId == other.caseId;
  }

  @override
  int get hashCode => key.hashCode ^ caseId.hashCode;
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditProfileScreen();
    },
  );
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
    : super(MapRoute.name, initialChildren: children);

  static const String name = 'MapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MapScreen();
    },
  );
}

/// generated route for
/// [MissingChildrenScreen]
class MissingChildrenRoute extends PageRouteInfo<void> {
  const MissingChildrenRoute({List<PageRouteInfo>? children})
    : super(MissingChildrenRoute.name, initialChildren: children);

  static const String name = 'MissingChildrenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MissingChildrenScreen();
    },
  );
}

/// generated route for
/// [MyReportsScreen]
class MyReportsRoute extends PageRouteInfo<void> {
  const MyReportsRoute({List<PageRouteInfo>? children})
    : super(MyReportsRoute.name, initialChildren: children);

  static const String name = 'MyReportsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MyReportsScreen();
    },
  );
}

/// generated route for
/// [NotificationsScreen]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationsScreen();
    },
  );
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [OtpScreen]
class OtpRoute extends PageRouteInfo<void> {
  const OtpRoute({List<PageRouteInfo>? children})
    : super(OtpRoute.name, initialChildren: children);

  static const String name = 'OtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OtpScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [ReportConfirmationScreen]
class ReportConfirmationRoute
    extends PageRouteInfo<ReportConfirmationRouteArgs> {
  ReportConfirmationRoute({
    Key? key,
    required String caseId,
    List<PageRouteInfo>? children,
  }) : super(
         ReportConfirmationRoute.name,
         args: ReportConfirmationRouteArgs(key: key, caseId: caseId),
         initialChildren: children,
       );

  static const String name = 'ReportConfirmationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReportConfirmationRouteArgs>();
      return ReportConfirmationScreen(key: args.key, caseId: args.caseId);
    },
  );
}

class ReportConfirmationRouteArgs {
  const ReportConfirmationRouteArgs({this.key, required this.caseId});

  final Key? key;

  final String caseId;

  @override
  String toString() {
    return 'ReportConfirmationRouteArgs{key: $key, caseId: $caseId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReportConfirmationRouteArgs) return false;
    return key == other.key && caseId == other.caseId;
  }

  @override
  int get hashCode => key.hashCode ^ caseId.hashCode;
}

/// generated route for
/// [ReportFoundScreen]
class ReportFoundRoute extends PageRouteInfo<void> {
  const ReportFoundRoute({List<PageRouteInfo>? children})
    : super(ReportFoundRoute.name, initialChildren: children);

  static const String name = 'ReportFoundRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReportFoundScreen();
    },
  );
}

/// generated route for
/// [ReportMissingScreen]
class ReportMissingRoute extends PageRouteInfo<void> {
  const ReportMissingRoute({List<PageRouteInfo>? children})
    : super(ReportMissingRoute.name, initialChildren: children);

  static const String name = 'ReportMissingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReportMissingScreen();
    },
  );
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
