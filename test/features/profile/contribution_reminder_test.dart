import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/profile/domain/contribution_reminder.dart';

void main() {
  group('ContributionReminder', () {
    const reminder = ContributionReminder(dayOfMonth: 5, minuteOfDay: 9 * 60);

    test('splits the time into hour and minute', () {
      const r = ContributionReminder(dayOfMonth: 1, minuteOfDay: 20 * 60 + 30);
      expect((r.hour, r.minute), (20, 30));
    });

    test('defaults to day 1 at 9:00', () {
      expect(ContributionReminder.initial.dayOfMonth, 1);
      expect(ContributionReminder.initial.minuteOfDay, 540);
    });

    test('fires later this month when the day has not arrived', () {
      expect(
        reminder.nextAfter(DateTime(2026, 3, 2, 12)),
        DateTime(2026, 3, 5, 9),
      );
    });

    test('fires next month when the time has passed', () {
      expect(
        reminder.nextAfter(DateTime(2026, 3, 5, 9)),
        DateTime(2026, 4, 5, 9),
      );
      expect(
        reminder.nextAfter(DateTime(2026, 3, 20)),
        DateTime(2026, 4, 5, 9),
      );
    });

    test('rolls over the year in December', () {
      expect(
        reminder.nextAfter(DateTime(2026, 12, 6)),
        DateTime(2027, 1, 5, 9),
      );
    });

    test('compares by value', () {
      expect(reminder, const ContributionReminder(dayOfMonth: 5));
      expect(reminder, isNot(reminder.copyWith(dayOfMonth: 6)));
    });
  });
}
