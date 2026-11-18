/// Monthly reminder to contribute to the goals: a day of the month and a
/// local time.
class ContributionReminder {
  const ContributionReminder({required this.dayOfMonth, this.minuteOfDay = 540})
    : assert(dayOfMonth >= 1 && dayOfMonth <= maxDay),
      assert(minuteOfDay >= 0 && minuteOfDay < 24 * 60);

  /// Days 29–31 do not exist every month, so the reminder stops at 28.
  static const maxDay = 28;

  /// Default when the reminder is turned on: day 1 at 9:00.
  static const initial = ContributionReminder(dayOfMonth: 1);

  final int dayOfMonth;

  /// Local time in minutes after midnight.
  final int minuteOfDay;

  int get hour => minuteOfDay ~/ 60;
  int get minute => minuteOfDay % 60;

  ContributionReminder copyWith({int? dayOfMonth, int? minuteOfDay}) =>
      ContributionReminder(
        dayOfMonth: dayOfMonth ?? this.dayOfMonth,
        minuteOfDay: minuteOfDay ?? this.minuteOfDay,
      );

  /// The first local date-time strictly after [now] when the reminder fires.
  DateTime nextAfter(DateTime now) {
    var candidate = DateTime(now.year, now.month, dayOfMonth, hour, minute);
    if (!candidate.isAfter(now)) {
      candidate = DateTime(now.year, now.month + 1, dayOfMonth, hour, minute);
    }
    return candidate;
  }

  @override
  bool operator ==(Object other) =>
      other is ContributionReminder &&
      other.dayOfMonth == dayOfMonth &&
      other.minuteOfDay == minuteOfDay;

  @override
  int get hashCode => Object.hash(dayOfMonth, minuteOfDay);
}
