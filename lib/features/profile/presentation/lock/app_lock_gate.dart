import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_lock_controller.dart';
import 'lock_screen.dart';

/// Shows [LockScreen] over the app while it is locked, and tells the lock
/// when the app goes to and comes back from the background.
class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onPause: () =>
          ref.read(appLockProvider.notifier).wentToBackground(DateTime.now()),
      onResume: () =>
          ref.read(appLockProvider.notifier).cameToForeground(DateTime.now()),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locked = ref.watch(appLockProvider.select((s) => s.locked));
    return Stack(
      children: [
        // Hidden from screen readers and paused while covered.
        ExcludeSemantics(
          excluding: locked,
          child: TickerMode(enabled: !locked, child: widget.child),
        ),
        if (locked) const Positioned.fill(child: LockScreen()),
      ],
    );
  }
}
