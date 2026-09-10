/// Governorate + city models for location dropdowns.
///
/// The list always comes from [LocationsRepository] (API in real mode,
/// bundled fallback in mock/offline mode) — never imported statically
/// by the UI.
class Governorate {
  const Governorate({this.id, required this.name, this.cities = const []});

  final String? id;
  final String name;
  final List<City> cities;

  List<String> get cityNames => cities.map((c) => c.name).toList();

  factory Governorate.fromJson(Map<String, dynamic> json) {
    final rawCities = json['cities'] ?? json['cityList'] ?? json['areas'];
    final cities = rawCities is List
        ? rawCities.map((e) {
            if (e is String) return City(name: e);
            if (e is Map) {
              return City.fromJson(
                e.map((k, v) => MapEntry(k.toString(), v)),
              );
            }
            return null;
          }).whereType<City>().toList()
        : <City>[];
    return Governorate(
      id: (json['id'] ?? json['_id'])?.toString(),
      name: (json['name'] ?? json['nameAr'] ?? json['arabicName'] ?? '')
          .toString(),
      cities: cities,
    );
  }
}

class City {
  const City({this.id, required this.name});

  final String? id;
  final String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: (json['id'] ?? json['_id'])?.toString(),
        name: (json['name'] ?? json['nameAr'] ?? json['arabicName'] ?? '')
            .toString(),
      );
}
