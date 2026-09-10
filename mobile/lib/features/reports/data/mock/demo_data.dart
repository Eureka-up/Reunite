import '../../domain/child_case.dart';
import 'demo_found.dart';
import 'demo_locations.dart';
import 'demo_missing.dart';
import 'demo_resolved.dart';

export 'demo_found.dart';
export 'demo_locations.dart';
export 'demo_missing.dart';
export 'demo_resolved.dart';

/// Realistic mock data clearly intended for demonstration only.
/// Names/persons are fictional. Coordinates correspond to real Egyptian
/// neighborhoods so the map and distance features feel authentic.
///
/// Lists live in `demo_missing.dart` / `demo_found.dart` / `demo_resolved.dart`;
/// this file keeps the original `DemoData.*` API so existing imports work.
class DemoData {
  const DemoData._();

  static const nasrCity = DemoLocations.nasrCity;
  static const heliopolis = DemoLocations.heliopolis;
  static const giza = DemoLocations.giza;
  static const alexandria = DemoLocations.alexandria;
  static const dokki = DemoLocations.dokki;

  static List<ChildCase> get missingCases => DemoMissing.missingCases;
  static List<ChildCase> get foundCases => DemoFound.foundCases;
  static List<ChildCase> get resolvedCases => DemoResolved.resolvedCases;

  static List<ChildCase> get allMissing => missingCases;
  static List<ChildCase> get allFound => foundCases;
  static List<ChildCase> get allResolved => resolvedCases;

  static List<String> get popularAreas => DemoLocations.popularAreas;
}
