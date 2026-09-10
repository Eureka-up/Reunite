import '../../../../core/services/location_service.dart';
import '../../../shared/domain/app_enums.dart';
import '../../domain/child_case.dart';
import 'inputs.dart';
import 'models.dart';

export 'inputs.dart';
export 'models.dart';
export 'mock_child_case_repository.dart';
export 'mock_queries.dart';
export 'mock_seed_ops.dart';

/// Search/filter parameters for browsing missing children.
class CasesQuery {
  const CasesQuery({
    this.search,
    this.city,
    this.area,
    this.gender,
    this.minAge,
    this.maxAge,
    this.activeOnly = false,
    this.foundOnly = false,
    this.sortNewest = true,
  });

  final String? search;
  final String? city;
  final String? area;
  final Gender? gender;
  final int? minAge;
  final int? maxAge;
  final bool activeOnly;
  final bool foundOnly;
  final bool sortNewest;

  CasesQuery copyWith({
    String? search,
    String? city,
    String? area,
    Gender? gender,
    int? minAge,
    int? maxAge,
    bool? activeOnly,
    bool? foundOnly,
    bool? sortNewest,
  }) {
    return CasesQuery(
      search: search,
      city: city,
      area: area,
      gender: gender,
      minAge: minAge,
      maxAge: maxAge,
      activeOnly: activeOnly ?? this.activeOnly,
      foundOnly: foundOnly ?? this.foundOnly,
      sortNewest: sortNewest ?? this.sortNewest,
    );
  }
}

/// Repository for browsing child cases and reports.
abstract class ChildCaseRepository {
  Stream<List<ChildCase>> watchMissing();
  Future<List<ChildCase>> getMissing(CasesQuery query);
  Future<ChildCase> getById(String id);

  /// Cases near [location] within [radiusMeters].
  Future<List<ChildCase>> getNearby(LatLng location, {int radiusMeters});
  Future<List<ChildCase>> getFound();
  Future<CaseStatistics> getStatistics();

  /// Possible matches for a found case.
  Future<List<PossibleMatch>> getPossibleMatches(String missingCaseId);
  Future<void> reportSighting(SightingInput input);
}

/// Repository for submitting reports and listing the current user's reports.
abstract class ReportsRepository {
  Future<ChildCase> submitMissing(MissingReportInput input);
  Future<ChildCase> submitFound(FoundReportInput input);
  Future<List<ChildCase>> myReports();
  Future<List<ChildCase>> myFindings();
  Future<List<ChildCase>> mySightings();
}
