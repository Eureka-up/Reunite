import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../reports/domain/child_case.dart';

/// A simple, non-interactive map preview used in case details.
class CaseMapView extends StatelessWidget {
  const CaseMapView({super.key, required this.caseData, this.height = 200});

  final ChildCase caseData;
  final double height;

  @override
  Widget build(BuildContext context) {
    final coords = caseData.coordinates;
    final fallback = const ll.LatLng(30.0444, 31.2357);
    final center = coords == null
        ? fallback
        : ll.LatLng(coords.latitude, coords.longitude);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        ),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: 13,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.reunitee.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: center,
                      width: 42,
                      height: 42,
                      child: _PulsePin(isFound: caseData.isFound),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: AppDimens.md,
              bottom: AppDimens.md,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.md, vertical: 6),
                decoration: BoxDecoration(
                  color: context.palette.surface,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                  boxShadow: [
                    BoxShadow(
                      color: context.palette.cardShadow,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 15,
                      color: caseData.isFound
                          ? AppColors.success
                          : AppColors.emergency,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      caseData.lastKnownLocation,
                      style: context.textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsePin extends StatelessWidget {
  const _PulsePin({required this.isFound});

  final bool isFound;

  @override
  Widget build(BuildContext context) {
    final color = isFound ? AppColors.success : AppColors.emergency;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.45),
              blurRadius: 14,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          isFound ? Icons.check_rounded : Icons.person_search_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
