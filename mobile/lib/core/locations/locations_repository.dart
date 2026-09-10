import 'location_models.dart';

/// Source of governorates + cities for location dropdowns.
///
/// Mock mode returns the bundled offline list; real mode calls
/// `GET /locations/governorates` (see [ApiEndpoints.governorates])
/// and falls back to the bundled list when offline.
abstract class LocationsRepository {
  Future<List<Governorate>> getGovernorates();
}
