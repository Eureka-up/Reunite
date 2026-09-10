import '../../../../core/services/location_service.dart';
import '../../../shared/domain/app_enums.dart';
import '../../domain/child_case.dart';

/// Resolved-cases demo seed, extracted from `demo_data.dart`.
class DemoResolved {
  const DemoResolved._();

  static final List<ChildCase> resolvedCases = [
    ChildCase(
      id: 'RC-0900',
      type: ReportType.missing,
      name: 'سلمى',
      age: 8,
      gender: Gender.female,
      status: CaseStatus.caseClosed,
      urgency: UrgencyLevel.low,
      lastKnownLocation: 'المعادي',
      city: 'القاهرة',
      area: 'المعادي',
      missingSince: DateTime.now().subtract(const Duration(days: 6)),
      lastSeen: DateTime.now().subtract(const Duration(days: 6)),
      clothing: '',
      description: 'تم العثور على الطفلة وعودتها إلى أسرتها.',
      locality: 'seed-selma-1',
      coordinates: LatLng(29.9689, 31.2507),
    ),
    ChildCase(
      id: 'RC-0901',
      type: ReportType.missing,
      name: 'كريم',
      age: 9,
      gender: Gender.male,
      status: CaseStatus.childFound,
      urgency: UrgencyLevel.low,
      lastKnownLocation: 'شبرا',
      city: 'القاهرة',
      area: 'شبرا',
      missingSince: DateTime.now().subtract(const Duration(days: 3)),
      lastSeen: DateTime.now().subtract(const Duration(days: 3)),
      clothing: '',
      description: 'تم العثور على الطفل بفضل بلاغ من المجتمع.',
      locality: 'seed-kareem-1',
      coordinates: LatLng(30.0833, 31.2451),
    ),
  ];
}
