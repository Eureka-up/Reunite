import 'dart:async';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/child_case.dart';
import 'case_json_mapper.dart';
import 'child_case_repository.dart';
import 'remote_payloads.dart';

export 'case_json_mapper.dart';
export 'remote_payloads.dart';

/// REST-backed cases repository. Same interface as [MockChildCaseRepository],
/// so flipping `USE_MOCK` requires no UI changes.
///
/// Backend contract:
/// GET /cases/missing?search=&city=&gender=&minAge=&maxAge=&sort=newest
/// GET /cases/found
/// GET /cases/:id
/// GET /cases/nearby?lat=&lng=&radius=
/// GET /cases/statistics
/// GET /cases/:id/matches
/// POST /sightings
/// POST /cases/missing
/// POST /cases/found
class RemoteChildCaseRepository implements ChildCaseRepository, ReportsRepository {
  RemoteChildCaseRepository(this._api);
  final ApiClient _api;
  final StreamController<List<ChildCase>> _controller =
      StreamController<List<ChildCase>>.broadcast();

  @override
  Stream<List<ChildCase>> watchMissing() => _controller.stream;

  @override
  Future<List<ChildCase>> getMissing(CasesQuery query) async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.missingCases,
        queryParameters: missingQueryParams(query)));
    final list = parseCaseList(res.data);
    _controller.add(list);
    return list;
  }

  @override
  Future<List<ChildCase>> getFound() async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.foundCases));
    return parseCaseList(res.data);
  }

  @override
  Future<ChildCase> getById(String id) async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.caseById(id)));
    return ChildCase.fromJson(normalizeCaseJson(parseSingleCaseMap(res.data)));
  }

  @override
  Future<List<ChildCase>> getNearby(LatLng location, {int radiusMeters = 10000}) async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.nearby,
        queryParameters: nearbyParams(location, radiusMeters)));
    return parseCaseList(res.data);
  }

  @override
  Future<CaseStatistics> getStatistics() async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.statistics));
    final data = res.data;
    final Map m = data is Map && data['data'] is Map
        ? data['data'] as Map
        : (data is Map ? data : const {});
    return CaseStatistics(
      activeCases: statsIntOf(m, 'activeCases'),
      childrenFound: statsIntOf(m, 'childrenFound'),
      reportsToday: statsIntOf(m, 'reportsToday'),
      reunifications: statsIntOf(m, 'reunifications', statsIntOf(m, 'childrenFound')),
    );
  }

  @override
  Future<List<PossibleMatch>> getPossibleMatches(String missingCaseId) async {
    final res = await _api.run(
        (dio) => dio.get(ApiEndpoints.possibleMatches(missingCaseId)));
    return parseMatchEnvelopes(res.data).map(parsePossibleMatch).toList();
  }

  @override
  Future<void> reportSighting(SightingInput input) async {
    await _api.run(
        (dio) => dio.post(ApiEndpoints.sightings, data: sightingPayload(input)));
  }

  @override
  Future<ChildCase> submitMissing(MissingReportInput input) async {
    // If the backend expects multipart for photos, build FormData here.
    final res = await _api.run(
        (dio) => dio.post(ApiEndpoints.submitMissing, data: missingPayload(input)));
    return ChildCase.fromJson(normalizeCaseJson(parseSingleCaseMap(res.data)));
  }

  @override
  Future<ChildCase> submitFound(FoundReportInput input) async {
    final res = await _api.run(
        (dio) => dio.post(ApiEndpoints.submitFound, data: foundPayload(input)));
    return ChildCase.fromJson(normalizeCaseJson(parseSingleCaseMap(res.data)));
  }

  @override
  Future<List<ChildCase>> myReports() async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.myReports));
    return parseCaseList(res.data);
  }

  @override
  Future<List<ChildCase>> myFindings() async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.myFindings));
    return parseCaseList(res.data);
  }

  @override
  Future<List<ChildCase>> mySightings() async {
    final res = await _api.run((dio) => dio.get(ApiEndpoints.mySightings));
    return parseCaseList(res.data);
  }
}
