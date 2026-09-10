import '../../domain/child_case.dart';

/// A possible match between a missing and a found report.
class PossibleMatch {
  const PossibleMatch({
    required this.foundCase,
    required this.matchPercent,
    required this.distanceMeters,
    required this.timeGap,
  });

  final ChildCase foundCase;
  final double matchPercent;
  final double distanceMeters;
  final Duration timeGap;
}

/// Dashboard statistics.
class CaseStatistics {
  const CaseStatistics({
    required this.activeCases,
    required this.childrenFound,
    required this.reportsToday,
    required this.reunifications,
  });

  final int activeCases;
  final int childrenFound;
  final int reportsToday;
  final int reunifications;
}
