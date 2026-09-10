import '../../../../core/services/location_service.dart';
import '../../../shared/domain/app_enums.dart';
import '../../domain/child_case.dart';

/// Found-cases demo seed, extracted from `demo_data.dart`.
class DemoFound {
  const DemoFound._();

  static final List<ChildCase> foundCases = [
    ChildCase(
      id: 'RF-2001',
      type: ReportType.found,
      name: 'طفل غير معروف الهوية',
      age: 6,
      gender: Gender.male,
      status: CaseStatus.published,
      urgency: UrgencyLevel.high,
      lastKnownLocation: 'محطة مترو الأوبرا',
      city: 'القاهرة',
      area: 'وسط البلد / الأوبرا',
      missingSince: DateTime.now().subtract(const Duration(hours: 5)),
      lastSeen: DateTime.now().subtract(const Duration(hours: 5)),
      clothing: 'تيشيرت رمادي، بنطال أزرق',
      description: 'طفل يبدو ضائعًا، وجد في انتظار المساعدة.',
      locality: 'seed-found-1',
      coordinates: LatLng(30.0469, 31.2317),
    ),
    ChildCase(
      id: 'RF-2002',
      type: ReportType.found,
      name: 'طفلة غير معروفة الهوية',
      age: 4,
      gender: Gender.female,
      status: CaseStatus.published,
      urgency: UrgencyLevel.medium,
      lastKnownLocation: 'حديقة حدائق القبة',
      city: 'القاهرة',
      area: 'حدائق القبة',
      missingSince: DateTime.now().subtract(const Duration(hours: 9)),
      lastSeen: DateTime.now().subtract(const Duration(hours: 9)),
      clothing: 'فستان أحمر بنقاط بيضاء',
      description: 'وجدت قرب مدخل الحديقة.',
      locality: 'seed-found-2',
      coordinates: LatLng(30.0806, 31.2568),
    ),
  ];
}
