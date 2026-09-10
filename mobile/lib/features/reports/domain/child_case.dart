import '../../../core/services/location_service.dart';
import '../../shared/domain/app_enums.dart';
import '../../auth/domain/user.dart';

part 'child_case_copy.dart';

/// A single child report (missing or found).
class ChildCase {
  const ChildCase({
    required this.id,
    required this.type,
    required this.name,
    required this.age,
    required this.gender,
    required this.status,
    required this.urgency,
    required this.lastKnownLocation,
    required this.city,
    required this.area,
    required this.missingSince,
    required this.lastSeen,
    required this.clothing,
    required this.description,
    this.distinguishingMarks,
    this.photoPath,
    this.locality,
    this.reporter,
    this.verified = false,
    this.coordinates,
  });

  final String id;
  final ReportType type;
  final String name;
  final int age;
  final Gender gender;
  final CaseStatus status;
  final UrgencyLevel urgency;

  /// Human friendly last location label, e.g. "شارع عباس العقاد".
  final String lastKnownLocation;

  final String city;
  final String area;
  final DateTime missingSince;
  final DateTime lastSeen;

  /// Optional geographic coordinates for the map (if shared).
  final LatLng? coordinates;

  final String clothing;
  final String description;
  final String? distinguishingMarks;
  final String? locality;
  final String? photoPath;
  final User? reporter;
  final bool verified;

  bool get isMissing => type == ReportType.missing;
  bool get isFound => type == ReportType.found;
  bool get isActive => status.isActive;
  bool get isResolved => status.isResolved;

  /// A case is "urgent" when it's missing + active + high urgency.
  bool get isUrgent => isMissing && isActive && urgency == UrgencyLevel.high;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'name': name,
        'age': age,
        'gender': gender.name,
        'status': status.name,
        'urgency': urgency.name,
        'lastKnownLocation': lastKnownLocation,
        'city': city,
        'area': area,
        'missingSince': missingSince.toIso8601String(),
        'lastSeen': lastSeen.toIso8601String(),
        'clothing': clothing,
        'description': description,
        'distinguishingMarks': distinguishingMarks,
        'photoPath': photoPath,
        'verified': verified,
        'coordinates': coordinates?.toJson(),
      };

  factory ChildCase.fromJson(Map<String, dynamic> json) => ChildCase(
        id: json['id'] as String,
        type: ReportType.values.byName(json['type'] as String),
        name: json['name'] as String,
        age: (json['age'] as num).toInt(),
        gender: Gender.values.byName(json['gender'] as String),
        status: CaseStatus.values.byName(json['status'] as String),
        urgency: UrgencyLevel.values.byName(json['urgency'] as String),
        lastKnownLocation: json['lastKnownLocation'] as String,
        city: json['city'] as String,
        area: json['area'] as String,
        missingSince: DateTime.parse(json['missingSince'] as String),
        lastSeen:
            DateTime.tryParse(json['lastSeen'] as String? ?? '') ??
            DateTime.parse(json['missingSince'] as String),
        clothing: json['clothing'] as String? ?? '',
        description: json['description'] as String? ?? '',
        distinguishingMarks: json['distinguishingMarks'] as String?,
        photoPath: json['photoPath'] as String?,
        verified: json['verified'] as bool? ?? false,
        coordinates: json['coordinates'] == null
            ? null
            : LatLng.fromJson(json['coordinates'] as Map<String, dynamic>),
      );
}
