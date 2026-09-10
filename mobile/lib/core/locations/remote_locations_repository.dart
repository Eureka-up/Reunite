import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import 'location_models.dart';
import 'locations_repository.dart';
import 'mock_locations_repository.dart';

/// REST-backed locations: `GET /locations/governorates`.
///
/// Falls back to the bundled offline list when the request fails,
/// so dropdowns still work without connectivity.
class RemoteLocationsRepository implements LocationsRepository {
  RemoteLocationsRepository(this._api);

  final ApiClient _api;

  @override
  Future<List<Governorate>> getGovernorates() async {
    try {
      final res = await _api.run(
        (dio) => dio.get(ApiEndpoints.governorates),
      );
      return _parse(res.data);
    } catch (_) {
      return MockLocationsRepository.bundledGovernorates();
    }
  }

  List<Governorate> _parse(dynamic data) {
    final List items;
    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic>) {
      final inner = data['data'];
      if (inner is List) {
        items = inner;
      } else if (inner is Map && inner['governorates'] is List) {
        items = inner['governorates'] as List;
      } else if (data['governorates'] is List) {
        items = data['governorates'] as List;
      } else {
        items = const [];
      }
    } else {
      items = const [];
    }
    final parsed = items
        .whereType<Map<String, dynamic>>()
        .map((e) {
          try {
            return Governorate.fromJson(e);
          } catch (_) {
            return null;
          }
        })
        .whereType<Governorate>()
        .where((g) => g.name.isNotEmpty)
        .toList();
    return parsed.isEmpty
        ? MockLocationsRepository.bundledGovernorates()
        : parsed;
  }
}
