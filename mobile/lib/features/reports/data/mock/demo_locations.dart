import '../../../../core/services/location_service.dart';

/// Shared demo coordinates + areas, extracted from `demo_data.dart`.
class DemoLocations {
  const DemoLocations._();
  static const LatLng nasrCity = LatLng(30.0588, 31.3309);
  static const LatLng heliopolis = LatLng(30.0893, 31.3269);
  static const LatLng giza = LatLng(30.0131, 31.2089);
  static const LatLng alexandria = LatLng(31.2001, 29.9187);
  static const LatLng dokki = LatLng(30.0379, 31.2070);

  static const List<String> popularAreas = [
    'مدينة نصر',
    'مصر الجديدة',
    'الجيزة',
    'المعادي',
    'حدائق القبة',
    'السيدة زينب',
    'شبرا',
    'الإسكندرية',
  ];
}
