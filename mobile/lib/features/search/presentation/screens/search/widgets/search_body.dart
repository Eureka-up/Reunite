import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../search_cubit.dart';
import 'search_results.dart';
import 'search_empty.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key, required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      SearchLoading() => const Center(child: CircularProgressIndicator()),
      SearchError() => Padding(
          padding: const EdgeInsets.all(AppDimens.xl),
          child: ErrorState(
            message: context.tr('errors.title'),
            onRetry: () => context.read<SearchCubit>().loadInitial(),
          ),
        ),
      SearchResults(:final query, :final results, :final recent) => SearchResultsList(
          query: query,
          results: results,
          recent: recent,
        ),
      SearchEmpty(:final recent) => SearchEmptyView(recent: recent),
      _ => const SizedBox(),
    };
  }
}
