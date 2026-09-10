import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../notifications/presentation/notifications_cubit.dart';
import '../../home_cubit.dart';
import 'widgets/hero_banner.dart';
import 'widgets/home_body.dart';
import 'widgets/modern_sliver_header.dart';
import 'widgets/search_section.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.watch<HomeCubit>();
    final notifCubit = context.watch<NotificationsCubit>();
    final unread = switch (notifCubit.state) {
      NotificationsLoaded(:final items) => items.where((n) => !n.read).length,
      _ => 0,
    };

    return Scaffold(
      backgroundColor: context.palette.background,
      body: RefreshIndicator(
        onRefresh: () => homeCubit.load(),
        color: AppColors.primary,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            ModernSliverHeader(unreadCount: unread),
            SliverToBoxAdapter(
              child: HeroBanner(
                onSearchTap: () => context.router.push(const SearchRoute()),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.08),
            ),
            SliverToBoxAdapter(
              child: SearchSection(
                onSearchTap: () => context.router.push(const SearchRoute()),
              ),
            ),
            SliverToBoxAdapter(
              child: HomeBody(state: homeCubit.state, cubit: homeCubit),
            ),
          ],
        ),
      ),
    );
  }
}
