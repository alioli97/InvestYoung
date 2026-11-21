import 'package:material_ui/material_ui.dart';

/// Closes the on-screen keyboard when the user taps outside a text field or
/// starts dragging a scrollable.
///
/// iOS numeric keyboards have no return or "Done" key, and Flutter only
/// unfocuses a field on outside taps for mouse pointers, so without this a
/// numeric field could not be left on iOS. It also uncovers bottom bars (such
/// as the onboarding navigation buttons) that the keyboard hides.
///
/// Taps on buttons, chips and text fields still reach them: their gesture
/// recognizers win the arena over this outer one.
class KeyboardDismisser extends StatelessWidget {
  const KeyboardDismisser({super.key, required this.child});

  final Widget child;

  static void _dismiss() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollStartNotification>(
      onNotification: (notification) {
        // Only drags by the user; scrolls such as the one that reveals the
        // focused field when the keyboard opens have no drag details.
        if (notification.dragDetails != null) _dismiss();
        return false;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        // Not an action for screen readers: VoiceOver/TalkBack would announce
        // the whole screen as an unlabeled button.
        excludeFromSemantics: true,
        onTap: _dismiss,
        child: child,
      ),
    );
  }
}
