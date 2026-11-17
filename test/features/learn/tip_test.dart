import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/features/learn/data/tips_repository.dart';
import 'package:invest_young/features/learn/domain/tip.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ofTheDay', () {
    const tips = [
      Tip(id: 'a', text: 'A'),
      Tip(id: 'b', text: 'B'),
      Tip(id: 'c', text: 'C'),
    ];

    test('is stable during a day and changes the next day', () {
      final morning = Tip.ofTheDay(tips, DateTime(2026, 11, 17, 8));
      final night = Tip.ofTheDay(tips, DateTime(2026, 11, 17, 23, 59));
      final tomorrow = Tip.ofTheDay(tips, DateTime(2026, 11, 18, 8));
      expect(night, same(morning));
      expect(tomorrow, isNot(same(morning)));
    });

    test('cycles through every tip', () {
      final seen = {
        for (var d = 0; d < 3; d++)
          Tip.ofTheDay(tips, DateTime(2026, 1, 1 + d))!.id,
      };
      expect(seen, {'a', 'b', 'c'});
    });

    test('is null without tips', () {
      expect(Tip.ofTheDay(const [], DateTime(2026)), isNull);
    });
  });

  test('es and ca tip files have the same ids', () async {
    final repo = TipsRepository(rootBundle);
    final es = await repo.load('es');
    final ca = await repo.load('ca');
    expect(es, isNotEmpty);
    expect(es.map((t) => t.id), ca.map((t) => t.id));
    expect(es.every((t) => t.text.trim().isNotEmpty), isTrue);
  });
}
