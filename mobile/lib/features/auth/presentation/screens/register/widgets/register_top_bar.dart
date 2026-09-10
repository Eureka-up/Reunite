import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/settings/settings_cubit.dart';
import '../../../../../../core/utils/context_extensions.dart';

class RegisterTopBar extends StatelessWidget {
  const RegisterTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsCubit>().state as SettingsLoaded;
    final cubit = context.read<AppSettingsCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              context.isRtl
                  ? Icons.arrow_forward_ios_rounded
                  : Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
        const Spacer(),
        GestureDetector(
          onTap: () {
            final newLocale = settings.language.languageCode == 'ar'
                ? const Locale('en')
                : const Locale('ar');
            cubit.setLanguage(newLocale);
            context.setLocale(newLocale);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language_rounded,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  settings.language.languageCode == 'ar' ? 'EN' : 'عربي',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            cubit.setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: AnimatedSwitcher(
              duration: 300.ms,
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(isDark),
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
      ],
    );
  }
}
