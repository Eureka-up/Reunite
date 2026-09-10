import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/storage/stores.dart';
import '../../../../reports/data/repositories/child_case_repository.dart';
import '../../search_cubit.dart';
import 'widgets/search_view.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(
        getIt<ChildCaseRepository>(),
        cache: getIt<CacheStore>(),
      ),
      child: const SearchView(),
    );
  }
}
