import '../constants/egypt_locations.dart';
import 'location_models.dart';
import 'locations_repository.dart';

/// Offline/bundled locations (demo mode).
///
/// This is the ONLY place that reads the static bundle — the UI always
/// goes through [LocationsRepository], so switching to the API requires
/// no UI changes.
class MockLocationsRepository implements LocationsRepository {
  const MockLocationsRepository();

  @override
  Future<List<Governorate>> getGovernorates() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return bundledGovernorates();
  }

  /// Shared fallback used by the remote repo when the API is unreachable.
  static List<Governorate> bundledGovernorates() =>
      EgyptLocations.governorateCities.entries
          .map(
            (e) => Governorate(
              name: e.key,
              cities: e.value.map((c) => City(name: c)).toList(),
            ),
          )
          .toList();
}
