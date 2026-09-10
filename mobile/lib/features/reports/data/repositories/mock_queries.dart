import '../../../../core/services/location_service.dart';
import '../../domain/child_case.dart';
import 'child_case_repository.dart';

/// Pure query helpers for the in-memory mock, extracted so the mock
/// class file stays under the 150-line budget. No logic changes.
List<ChildCase> filterMissingCases(List<ChildCase> all, CasesQuery query) {
  var result = List<ChildCase>.of(all);
  if (query.activeOnly) result = result.where((c) => c.isActive).toList();
  if (query.foundOnly) result = result.where((c) => c.isResolved).toList();
  final text = query.search?.trim().toLowerCase() ?? '';
  if (text.isNotEmpty) {
    result = result
        .where((c) =>
            c.name.toLowerCase().contains(text) ||
            c.id.toLowerCase().contains(text) ||
            c.area.toLowerCase().contains(text))
        .toList();
  }
  if (query.city != null) result = result.where((c) => c.city == query.city).toList();
  if (query.area != null) {
    result = result.where((c) => c.area.contains(query.area!)).toList();
  }
  if (query.gender != null) {
    result = result.where((c) => c.gender == query.gender).toList();
  }
  if (query.minAge != null) result = result.where((c) => c.age >= query.minAge!).toList();
  if (query.maxAge != null) result = result.where((c) => c.age <= query.maxAge!).toList();
  result = List.of(result);
  if (query.sortNewest) {
    result.sort((a, b) => b.missingSince.compareTo(a.missingSince));
  } else {
    result.sort((a, b) => a.missingSince.compareTo(b.missingSince));
  }
  return result;
}

/// Active cases near [location] within [radiusMeters].
List<ChildCase> nearbyMockCases(
  List<ChildCase> all,
  LatLng location, {
  int radiusMeters = 10000,
}) {
  final radius = radiusMeters.toDouble();
  return all.where((c) {
    final coords = c.coordinates;
    if (coords == null) return false;
    return coords.distanceMetersTo(location) <= radius;
  }).where((c) => c.isActive).toList();
}

/// Scores [found] candidates against [missing] (same formula as before).
List<PossibleMatch> buildMockMatches(ChildCase missing, List<ChildCase> found) {
  return found.where((f) => f.gender == missing.gender).map((f) {
    final ageGap = (f.age - missing.age).abs();
    final percent =
        (100 - ageGap * 8 - (f.isResolved ? 5 : 0)).clamp(40, 96).toDouble();
    final distance = missing.coordinates == null || f.coordinates == null
        ? 0.0
        : missing.coordinates!.distanceMetersTo(f.coordinates!);
    final timeGap = missing.missingSince.difference(f.missingSince).abs();
    return PossibleMatch(
      foundCase: f,
      matchPercent: percent,
      distanceMeters: distance,
      timeGap: timeGap,
    );
  }).toList();
}

/// Dashboard numbers derived from the in-memory lists.
CaseStatistics buildMockStatistics(
  List<ChildCase> allMissing,
  List<ChildCase> missing,
  List<ChildCase> resolved,
) {
  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  final todayCount =
      allMissing.where((c) => c.missingSince.isAfter(todayStart)).length + 2;
  return CaseStatistics(
    activeCases: missing.where((c) => c.isActive).length,
    childrenFound: resolved.length + 41,
    reportsToday: todayCount,
    reunifications: resolved.length + 87,
  );
}
