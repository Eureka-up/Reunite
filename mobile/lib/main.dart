import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/di/app_di.dart';
import 'core/di/feature_di.dart';
import 'core/router/app_router.dart';
import 'core/settings/settings_cubit.dart';
import 'core/storage/hive_service.dart';
import 'core/storage/stores.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  await initCoreDependencies();
  await initFeatureDependencies();

  final settings = AppSettingsCubit(getIt<PrefsStore>());
  getIt.registerLazySingleton<AppSettingsCubit>(() => settings);

  final router = AppRouter();
  getIt.registerLazySingleton<AppRouter>(() => router);

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: BlocProvider.value(
        value: settings,
        child: const ReuniteeApp(),
      ),
    ),
  );
}

class ReuniteeApp extends StatelessWidget {
  const ReuniteeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsState settings = context.watch<AppSettingsCubit>().state;
    final ThemeMode themeMode = switch (settings) {
      SettingsLoaded(:final themeMode) => themeMode,
    };
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
