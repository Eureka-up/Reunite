import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/settings/settings_cubit.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../auth/data/auth_repository.dart';
import '../../../../auth/domain/user.dart';
import '../../profile_cubit.dart';
import 'widgets/hero_profile_card.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_sections.dart';
import 'widgets/settings_groups.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit(getIt<AuthRepository>())..load()),
        BlocProvider.value(value: getIt<AppSettingsCubit>()),
      ],
      child: const ModernProfileView(),
    );
  }
}

class ModernProfileView extends StatelessWidget {
  const ModernProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    final User? user = state is ProfileLoaded ? state.user : null;

    return Scaffold(
      backgroundColor: context.palette.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          // ── AppBar ──
          SliverAppBar(
            pinned: true,
            floating: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: context.palette.background.withValues(alpha: 0.86),
            surfaceTintColor: Colors.transparent,
            title: Text(context.tr('profile.title'), style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12,left: 12),
                child: Material(
                  color: context.palette.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: context.palette.border)),
                  child: InkWell(
                    onTap: () => context.router.push(const SettingsRoute()),
                    borderRadius: BorderRadius.circular(12),
                    child: const SizedBox(width: 36, height: 36, child: Icon(Icons.settings_outlined, size: 18)),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
            sliver: SliverList.list(
              children: [
                // ── Hero Profile Card ──
                HeroProfileCard(user: user).animate().fadeIn(duration: 380.ms).slideY(begin: 0.06),
                const SizedBox(height: 22),

                // ── My Reports — only Missing & Found ──
                SectionHeader(icon: Icons.folder_rounded, title: context.tr('profile.myReports'), subtitle: context.tr('profile.reportsSubtitle')),
                const SizedBox(height: 10),
                const ReportsBento().animate().fadeIn(delay: 120.ms).slideY(begin: 0.04),
                // const SizedBox(height: 10),

                // ── Preferences ──
                const SectionHeader(icon: Icons.tune_rounded, title: 'Preferences', subtitle: 'App experience'),
                const SizedBox(height: 10),
                const PrefGroup().animate().fadeIn(delay: 160.ms).slideY(begin: 0.04),
                const SizedBox(height: 18),

                // ── Support ──
                const SectionHeader(icon: Icons.support_agent_rounded, title: 'Support', subtitle: 'Help & legal'),
                const SizedBox(height: 10),
                const SupportGroup().animate().fadeIn(delay: 200.ms).slideY(begin: 0.04),
                const SizedBox(height: 22),

                // ── Logout ──
                const ModernLogout().animate().fadeIn(delay: 240.ms),
                const SizedBox(height: 16),
                Text(context.tr('demo.notice'), textAlign: TextAlign.center, style: context.textTheme.bodySmall?.copyWith(color: context.palette.textMuted, fontSize: 11, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
