/// Formats distance with locale aware units. Western digits keep
/// numbers unambiguous in both Arabic and English.
class DistanceFormat {
  const DistanceFormat._();

  static String format(double meters) {
    if (meters < 1000) {
      final int m = meters.round();
      return '$m م';
    }
    final double km = meters / 1000;
    final String value = km >= 100 ? km.toStringAsFixed(0) : km.toStringAsFixed(1);
    return '$value كم';
  }
}