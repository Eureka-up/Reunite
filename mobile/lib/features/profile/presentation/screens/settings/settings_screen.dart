import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/settings/settings_cubit.dart';
import '../../../../../core/utils/context_extensions.dart';
import 'widgets/language_picker.dart';
import 'widgets/notif_card.dart';
import 'widgets/radius_card.dart';
import 'widgets/section_title.dart';
import 'widgets/settings_hero.dart';
import 'widgets/theme_picker.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AppSettingsCubit>(),
      child: const ModernSettingsView(),
    );
  }
}

class ModernSettingsView extends StatelessWidget {
  const ModernSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppSettingsCubit>().state as SettingsLoaded;
    final cubit = context.read<AppSettingsCubit>();

    return Scaffold(
      backgroundColor: context.palette.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          // ── Modern AppBar ──
          SliverAppBar(
            pinned: true,
            floating: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: context.palette.background.withValues(alpha: 0.88),
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: context.palette.border)),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              ),
              onPressed: () => context.router.maybePop(),
            ),
            title: Text(context.tr('profile.settings'), style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            centerTitle: true,
          ),
          // ── Hero ──
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 6, 20, 14),
              child: SettingsHero(),
            ),
          ),
          // ── Content ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
            sliver: SliverList.list(
              children: [
                // Appearance
                SectionTitle(icon: Icons.palette_rounded, title: context.tr('profile.theme'), subtitle: context.tr('settings.lightDarkSystem')),
                const SizedBox(height: 10),
                ThemeGrid(mode: state.themeMode, onChanged: cubit.setThemeMode).animate().fadeIn(delay: 80.ms).slideY(begin: 0.04),
                const SizedBox(height: 22),

                // Language
                SectionTitle(icon: Icons.language_rounded, title: context.tr('profile.languageTitle'), subtitle: context.tr('settings.arabicEnglish')),
                const SizedBox(height: 10),
                LanguageGrid(current: state.language, onChanged: (l) { cubit.setLanguage(l); context.setLocale(l); }).animate().fadeIn(delay: 120.ms).slideY(begin: 0.04),
                const SizedBox(height: 22),

                // Alert radius
                SectionTitle(icon: Icons.radar_rounded, title: context.tr('profile.distanceRadius'), subtitle: context.tr('settings.howFar')),
                const SizedBox(height: 10),
                RadiusCard(current: state.alertRadiusMeters, onChanged: cubit.setAlertRadius).animate().fadeIn(delay: 160.ms).slideY(begin: 0.04),
                const SizedBox(height: 22),

                // Notifications
                SectionTitle(icon: Icons.notifications_rounded, title: context.tr('profile.notificationPrefs'), subtitle: 'Push & in-app alerts'),
                const SizedBox(height: 10),
                NotifCard(
                  pushEnabled: state.pushEnabled,
                  nearby: state.notifyNearby,
                  updates: state.notifyUpdates,
                  matches: state.notifyMatches,
                  onPush: cubit.setPushEnabled,
                  onNearby: cubit.setNotifyNearby,
                  onUpdates: cubit.setNotifyUpdates,
                  onMatches: cubit.setNotifyMatches,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.04),

                const SizedBox(height: 22),
                // Footer
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: context.palette.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: context.palette.border)),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, size: 16, color: context.palette.textMuted),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Settings are saved automatically and sync across devices.', style: context.textTheme.bodySmall?.copyWith(color: context.palette.textMuted, fontSize: 12))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
