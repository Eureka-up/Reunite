import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../notifications/data/notifications_repository.dart';
import '../../../../notifications/presentation/notifications_cubit.dart';
import '../../../../reports/data/repositories/child_case_repository.dart';
import '../../home_cubit.dart';
import 'widgets/modern_nav.dart';
import 'widgets/report_sheet.dart';

@RoutePage()
class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key});
  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  final List<PageRouteInfo> _tabs = const [
    HomeRoute(),
    MissingChildrenRoute(),
    MapRoute(),
    NotificationsRoute(),
    ProfileRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit(getIt<ChildCaseRepository>(), location: getIt<LocationService>())..load()),
        BlocProvider(create: (_) => NotificationsCubit(getIt<NotificationsRepository>())..load()),
      ],
      child: AutoTabsRouter(
        routes: _tabs,
        transitionBuilder: (context, child, animation) => FadeTransition(opacity: animation, child: child),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            extendBody: true,
            body: child,
            bottomNavigationBar: ModernNav(
              current: tabsRouter.activeIndex,
              onTap: (i) {
                HapticFeedback.selectionClick();
                tabsRouter.setActiveIndex(i);
              },
              onAdd: () {
                HapticFeedback.mediumImpact();
                _showSheet(context);
              },
            ),
          );
        },
      ),
    );
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.32),
      isScrollControlled: true,
      builder: (c) => ReportSheet(
        onMissing: () {
          Navigator.pop(c);
          getIt<AppRouter>().push(const ReportMissingRoute());
        },
        onFound: () {
          Navigator.pop(c);
          getIt<AppRouter>().push(const ReportFoundRoute());
        },
      ),
    );
  }
}
