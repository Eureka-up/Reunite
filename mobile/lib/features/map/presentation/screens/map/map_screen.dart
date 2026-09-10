import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../reports/data/repositories/child_case_repository.dart';
import '../../map_cubit.dart';
import 'widgets/map_view.dart';

@RoutePage()
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(
        getIt<ChildCaseRepository>(),
        location: getIt<LocationService>(),
      )..load(),
      child: const MapView(),
    );
  }
}
