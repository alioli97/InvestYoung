import 'package:flutter_test/flutter_test.dart';
import 'package:invest_young/core/widgets/keyboard_dismisser.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late FocusNode fieldFocus;
  late int buttonTaps;

  Future<void> pumpScreen(WidgetTester tester) async {
    fieldFocus = FocusNode();
    addTearDown(fieldFocus.dispose);
    buttonTaps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: KeyboardDismisser(
          child: Scaffold(
            body: ListView(
              children: [
                TextField(
                  key: const Key('field'),
                  focusNode: fieldFocus,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(key: Key('blank'), height: 300),
                FilledButton(
                  onPressed: () => buttonTaps++,
                  child: const Text('Next'),
                ),
                const SizedBox(height: 2000),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const Key('field')));
    await tester.pump();
    expect(fieldFocus.hasFocus, isTrue);
  }

  testWidgets('tapping outside the field closes the keyboard', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.byKey(const Key('blank')));
    await tester.pump();

    expect(fieldFocus.hasFocus, isFalse);
  });

  testWidgets('tapping the field again keeps it focused', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.byKey(const Key('field')));
    await tester.pump();

    expect(fieldFocus.hasFocus, isTrue);
  });

  testWidgets('buttons still receive the tap', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Next'));
    await tester.pump();

    expect(buttonTaps, 1);
  });

  testWidgets('dragging a scrollable closes the keyboard', (tester) async {
    await pumpScreen(tester);

    await tester.drag(find.byType(ListView), const Offset(0, -200));
    await tester.pumpAndSettle();

    expect(fieldFocus.hasFocus, isFalse);
  });
}
