import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../map_cubit.dart';
import 'map_body.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MapCubit>().state;
    return Scaffold(
      body: switch (state) {
        MapLoading() => const Center(child: CircularProgressIndicator()),
        MapError() => ErrorState(
            message: context.tr('errors.title'),
            onRetry: () => context.read<MapCubit>().load(),
          ),
        MapLoaded(
          :final userLocation,
          :final missing,
          :final found,
          :final radiusMeters,
        ) =>
          MapBody(
            userLocation: userLocation,
            missing: missing,
            found: found,
            radiusMeters: radiusMeters,
          ),
      },
    );
  }
}
