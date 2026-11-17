/// A short educational tip (Learn "Quick tips" and Home "tip of the day").
class Tip {
  const Tip({required this.id, required this.text});

  final String id;
  final String text;

  /// Rotates through [tips] once per local calendar day.
  static Tip? ofTheDay(List<Tip> tips, DateTime now) {
    if (tips.isEmpty) return null;
    final local = now.toLocal();
    final day = DateTime.utc(local.year, local.month, local.day);
    final daysSinceEpoch =
        day.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
    return tips[daysSinceEpoch % tips.length];
  }
}
