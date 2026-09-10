import 'dart:async';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/child_case.dart';
import '../../../shared/domain/app_enums.dart';
import '../mock/demo_data.dart';
import 'child_case_repository.dart';

/// In-memory mock implementation. Swappable for a REST-backed
/// implementation without touching the UI.
class MockChildCaseRepository implements ChildCaseRepository, ReportsRepository {
  MockChildCaseRepository();

  final StreamController<List<ChildCase>> _controller =
      StreamController<List<ChildCase>>.broadcast();

  final List<ChildCase> _missing = List.of(DemoData.missingCases);
  final List<ChildCase> _found = List.of(DemoData.foundCases);
  final List<ChildCase> _resolved = List.of(DemoData.resolvedCases);

  final List<ChildCase> _myReports = [];
  final List<ChildCase> _myFindings = [];
  final List<ChildCase> _mySightings = [];

  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 500));

  @override
  Stream<List<ChildCase>> watchMissing() => _controller.stream;

  List<ChildCase> get _allMissing => [..._missing, ..._resolved];

  @override
  Future<List<ChildCase>> getMissing(CasesQuery query) async {
    await _delay();
    return filterMissingCases(_allMissing, query);
  }

  @override
  Future<List<ChildCase>> getFound() async {
    await _delay();
    return List.of(_found);
  }

  @override
  Future<ChildCase> getById(String id) async {
    await _delay();
    final match = [..._allMissing, ..._found].where((c) => c.id == id).firstOrNull;
    if (match == null) throw const NotFoundFailure();
    return match;
  }

  @override
  Future<List<ChildCase>> getNearby(LatLng location, {int radiusMeters = 10000}) async {
    await _delay();
    return nearbyMockCases(_allMissing, location, radiusMeters: radiusMeters);
  }

  @override
  Future<CaseStatistics> getStatistics() async {
    await _delay();
    return buildMockStatistics(_allMissing, _missing, _resolved);
  }

  @override
  Future<List<PossibleMatch>> getPossibleMatches(String missingCaseId) async {
    await _delay();
    final missing = _allMissing.where((c) => c.id == missingCaseId).firstOrNull;
    if (missing == null) return const [];
    return buildMockMatches(missing, _found);
  }

  @override
  Future<void> reportSighting(SightingInput input) async {
    await _delay();
    final idx = _missing.indexWhere((c) => c.id == input.caseId);
    if (idx >= 0) {
      final updated = _missing[idx].copyWith(status: CaseStatus.possibleSighting);
      _missing[idx] = updated;
      if (!_mySightings.contains(updated)) _mySightings.add(updated);
      _controller.add(List.of(_missing));
    }
  }

  @override
  Future<ChildCase> submitMissing(MissingReportInput input) async {
    await _delay();
    final c = buildMockMissingCase(input, _missing.length);
    _missing.insert(0, c);
    _myReports.insert(0, c);
    _controller.add(List.of(_missing));
    return c;
  }

  @override
  Future<ChildCase> submitFound(FoundReportInput input) async {
    await _delay();
    final c = buildMockFoundCase(input, _found.length);
    _found.insert(0, c);
    _myFindings.insert(0, c);
    return c;
  }

  @override
  Future<List<ChildCase>> myReports() async {
    await _delay();
    return List.of(_myReports);
  }

  @override
  Future<List<ChildCase>> myFindings() async {
    await _delay();
    return List.of(_myFindings);
  }

  @override
  Future<List<ChildCase>> mySightings() async {
    await _delay();
    return List.of(_mySightings);
  }
}
