/// Minimal, dependency-free date/time formatting helpers.
class DateFormats {
  const DateFormats._();

  static String _two(int v) => v.toString().padLeft(2, '0');

  /// e.g. 12/08/2026
  static String date(DateTime dt) =>
      '${_two(dt.day)}/${_two(dt.month)}/${dt.year}';

  /// e.g. 14:30
  static String time(DateTime dt) => '${_two(dt.hour)}:${_two(dt.minute)}';

  /// e.g. 12/08/2026 - 14:30
  static String dateTime(DateTime dt) => '${date(dt)} - ${time(dt)}';

  /// Compact timestamp used in chat-like summaries: e.g. 14:30, yesterday, 12/08
  static String compact(DateTime dt) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime day = DateTime(dt.year, dt.month, dt.day);
    final int diff = today.difference(day).inDays;
    if (diff == 0) return time(dt);
    if (diff == 1) return 'yesterday';
    return '${_two(dt.day)}/${_two(dt.month)}';
  }
}