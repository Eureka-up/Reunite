import '../../../../core/services/location_service.dart';
import '../../../shared/domain/app_enums.dart';

/// Input for a new missing-child report.
class MissingReportInput {
  const MissingReportInput({
    required this.photoSeed,
    required this.name,
    required this.age,
    required this.gender,
    required this.missingSince,
    required this.lastKnownLocation,
    required this.city,
    required this.area,
    required this.clothing,
    required this.description,
    this.distinguishingMarks,
    this.phone,
    this.email,
    this.coordinates,
  });

  final String? photoSeed;
  final String name;
  final int age;
  final Gender gender;
  final DateTime missingSince;
  final String lastKnownLocation;
  final String city;
  final String area;
  final String clothing;
  final String description;
  final String? distinguishingMarks;
  final String? phone;
  final String? email;
  final LatLng? coordinates;
}

/// Input for a found-child report.
class FoundReportInput {
  const FoundReportInput({
    required this.photoSeed,
    required this.estimatedAge,
    required this.gender,
    required this.foundSince,
    required this.foundLocation,
    required this.city,
    required this.area,
    required this.clothing,
    required this.description,
    this.extraInfo,
    this.coordinates,
  });

  final String? photoSeed;
  final int estimatedAge;
  final Gender gender;
  final DateTime foundSince;
  final String foundLocation;
  final String city;
  final String area;
  final String clothing;
  final String description;
  final String? extraInfo;
  final LatLng? coordinates;
}

/// A reported sighting by a community member.
class SightingInput {
  const SightingInput({
    required this.caseId,
    required this.latitude,
    required this.longitude,
    required this.occurredAt,
    required this.description,
    this.notes,
    this.photoSeed,
  });

  final String caseId;
  final double latitude;
  final double longitude;
  final DateTime occurredAt;
  final String description;
  final String? notes;
  final String? photoSeed;
}
