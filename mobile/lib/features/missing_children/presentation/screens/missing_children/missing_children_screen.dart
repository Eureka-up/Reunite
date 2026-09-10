import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_dimens.dart';
import '../../../../../core/utils/context_extensions.dart';
import '../../../../reports/data/repositories/child_case_repository.dart';
import '../../missing_cubit.dart';
import 'widgets/case_slivers.dart';
import 'widgets/discover_app_bar.dart';
import 'widgets/discover_states.dart';
import 'widgets/results_bar.dart';
import 'widgets/search_and_filters.dart';

@RoutePage()
class MissingChildrenScreen extends StatelessWidget {
  const MissingChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MissingCubit(
        getIt<ChildCaseRepository>(),
        location: getIt<LocationService>(),
      ),
      child: const MissingView(),
    );
  }
}

class MissingView extends StatefulWidget {
  const MissingView({super.key});

  @override
  State<MissingView> createState() => MissingViewState();
}

class MissingViewState extends State<MissingView> {
  final _searchController = TextEditingController();
  bool _isGrid = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MissingCubit>();
    final state = cubit.state;

    return Scaffold(
      backgroundColor: context.palette.background,
      body: RefreshIndicator(
        onRefresh: () => cubit.load(),
        color: AppColors.primary,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: [
            DiscoverAppBar(
              count: state is MissingLoaded ? state.cases.length : 0,
              onMapTap: () => context.router.push(const MapRoute()),
            ),
            SearchAndFilters(
              controller: _searchController,
              onSearch: cubit.onSearch,
              cubit: cubit,
            ),
            if (state is MissingLoaded && state.cases.isNotEmpty)
              SliverToBoxAdapter(
                child: ResultsBar(
                  count: state.cases.length,
                  isGrid: _isGrid,
                  onToggleView: () => setState(() => _isGrid = !_isGrid),
                  cubit: cubit,
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(AppDimens.xl, 0, AppDimens.xl, 110),
              sliver: switch (state) {
                MissingLoading() => const MissingSkeletonSliver(),
                MissingLoaded(:final failure) when failure != null => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: ErrorCard(messageKey: failure.messageKey, onRetry: cubit.load),
                    ),
                  ),
                MissingLoaded(cases: final cases) when cases.isEmpty => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: EmptyDiscover(onClear: cubit.clearFilters),
                    ),
                  ),
                MissingLoaded(cases: final cases) => _isGrid
                    ? GridSliver(cases: cases, cubit: cubit)
                    : ListSliver(cases: cases, cubit: cubit),
              },
            ),
          ],
        ),
      ),
    );
  }
}
