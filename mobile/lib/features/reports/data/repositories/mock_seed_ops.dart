import '../../../auth/domain/user.dart';
import '../../../shared/domain/app_enums.dart';
import '../../domain/child_case.dart';
import 'inputs.dart';

/// Builders for new mock cases, extracted so the mock class file
/// stays under the 150-line budget. No logic changes.
ChildCase buildMockMissingCase(MissingReportInput input, int seq) {
  return ChildCase(
    id: 'RC-${1000 + seq + 900}',
    type: ReportType.missing,
    name: input.name,
    age: input.age,
    gender: input.gender,
    status: CaseStatus.underReview,
    urgency: UrgencyLevel.high,
    lastKnownLocation: input.lastKnownLocation,
    city: input.city,
    area: input.area,
    missingSince: input.missingSince,
    lastSeen: input.missingSince,
    clothing: input.clothing,
    description: input.description,
    distinguishingMarks: input.distinguishingMarks,
    locality: input.photoSeed,
    coordinates: input.coordinates,
    reporter: const User(id: 'me', fullName: 'المستخدم'),
  );
}

ChildCase buildMockFoundCase(FoundReportInput input, int seq) {
  return ChildCase(
    id: 'RF-${2000 + seq + 800}',
    type: ReportType.found,
    name: 'طفل غير معروف الهوية',
    age: input.estimatedAge,
    gender: input.gender,
    status: CaseStatus.published,
    urgency: UrgencyLevel.high,
    lastKnownLocation: input.foundLocation,
    city: input.city,
    area: input.area,
    missingSince: input.foundSince,
    lastSeen: input.foundSince,
    clothing: input.clothing,
    description: input.description,
    locality: input.photoSeed,
    coordinates: input.coordinates,
    reporter: const User(id: 'me', fullName: 'المستخدم'),
  );
}
