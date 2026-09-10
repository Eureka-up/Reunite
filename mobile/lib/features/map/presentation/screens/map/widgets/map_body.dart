import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/services/location_service.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_dimens.dart';
import '../../../../../reports/domain/child_case.dart';
import '../../../map_cubit.dart';
import 'marker_pin.dart';
import 'round_button.dart';
import 'bottom_sheet_preview.dart';

class MapBody extends StatelessWidget {
  const MapBody({
    super.key,
    required this.userLocation,
    required this.missing,
    required this.found,
    required this.radiusMeters,
  });

  final LatLng? userLocation;
  final List<ChildCase> missing;
  final List<ChildCase> found;
  final int radiusMeters;

  @override
  Widget build(BuildContext context) {
    final initialCenter = userLocation != null
        ? ll.LatLng(userLocation!.latitude, userLocation!.longitude)
        : const ll.LatLng(30.0444, 31.2357);

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(initialCenter: initialCenter, initialZoom: 12),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.reunitee.app',
            ),
            if (userLocation != null)
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: ll.LatLng(userLocation!.latitude, userLocation!.longitude),
                    radius: radiusMeters.toDouble(),
                    useRadiusInMeter: true,
                    color: AppColors.secondary.withValues(alpha: 0.08),
                    borderColor: AppColors.secondary.withValues(alpha: 0.3),
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
            if (userLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: ll.LatLng(userLocation!.latitude, userLocation!.longitude),
                    width: 24,
                    height: 24,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.navigation_rounded, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                for (final c in missing)
                  if (c.coordinates != null)
                    Marker(
                      point: ll.LatLng(c.coordinates!.latitude, c.coordinates!.longitude),
                      width: 36,
                      height: 36,
                      child: MarkerPin(
                        color: AppColors.emergency,
                        icon: Icons.person_search_rounded,
                        onTap: () =>
                            context.router.push(ChildDetailsRoute(caseId: c.id)),
                      ),
                    ),
                for (final c in found)
                  if (c.coordinates != null)
                    Marker(
                      point: ll.LatLng(c.coordinates!.latitude, c.coordinates!.longitude),
                      width: 36,
                      height: 36,
                      child: MarkerPin(
                        color: AppColors.info,
                        icon: Icons.child_care_rounded,
                        onTap: () =>
                            context.router.push(ChildDetailsRoute(caseId: c.id)),
                      ),
                    ),
              ],
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 8,
          left: AppDimens.md,
          child: MapRoundButton(
            icon: Icons.my_location_rounded,
            onTap: () => context.read<MapCubit>().load(),
          ),
        ),
        if (missing.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomSheetPreview(cases: missing),
          ),
      ],
    );
  }
}
