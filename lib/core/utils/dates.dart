// Pure date helpers.

/// Whole calendar months from [from] to [to] (0 if [to] is not after
/// [from]). A month only counts once its day of the month is reached:
/// 15 Jan → 14 Mar is 1 month, 15 Jan → 15 Mar is 2.
int monthsBetween(DateTime from, DateTime to) {
  final a = from.toLocal();
  final b = to.toLocal();
  var months = (b.year - a.year) * 12 + (b.month - a.month);
  if (b.day < a.day) months--;
  return months < 0 ? 0 : months;
}

/// [date] moved [months] calendar months, clamping the day to the target
/// month's length (31 Jan + 1 month → 28/29 Feb).
DateTime addMonths(DateTime date, int months) {
  final totalMonths = date.year * 12 + (date.month - 1) + months;
  final year = totalMonths ~/ 12;
  final month = totalMonths % 12 + 1;
  final lastDay = DateTime(year, month + 1, 0).day;
  final day = date.day > lastDay ? lastDay : date.day;
  return DateTime(year, month, day, date.hour, date.minute);
}
