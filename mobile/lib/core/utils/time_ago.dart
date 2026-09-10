/// Relative time labels resolved against a locale tag ('ar' | 'en').
/// Returns the raw translation key for named args.
enum TimeAgoGranularity { justNow, minutes, hours, days, weeks }

class TimeAgo {
  const TimeAgo._();

  /// Builds a key taking a `%{count}` named argument.
  static (TimeAgoGranularity, int) classify(DateTime dateTime, DateTime now) {
    final Duration diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return (TimeAgoGranularity.justNow, 0);
    if (diff.inMinutes < 60) return (TimeAgoGranularity.minutes, diff.inMinutes);
    if (diff.inHours < 24) return (TimeAgoGranularity.hours, diff.inHours);
    if (diff.inDays < 7) return (TimeAgoGranularity.days, diff.inDays);
    return (TimeAgoGranularity.weeks, (diff.inDays / 7).floor());
  }

  /// Localization key to translate with `{'count': n}`.
  static String key(DateTime dateTime, DateTime now) {
    final (granularity, _) = classify(dateTime, now);
    return switch (granularity) {
      TimeAgoGranularity.justNow => 'timeAgo.justNow',
      TimeAgoGranularity.minutes => 'timeAgo.minutes',
      TimeAgoGranularity.hours => 'timeAgo.hours',
      TimeAgoGranularity.days => 'timeAgo.days',
      TimeAgoGranularity.weeks => 'timeAgo.weeks',
    };
  }

  static int count(DateTime dateTime, DateTime now) {
    final (_, count) = classify(dateTime, now);
    return count;
  }
}