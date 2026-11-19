import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n.dart';
import '../../data/device_auth.dart';
import '../lock/app_lock_controller.dart';
import 'section_header.dart';

/// App lock with the device's biometrics/PIN. Hidden on web.
class SecuritySection extends ConsumerWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(deviceAuthProvider).isSupported) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final enabled = ref.watch(appLockProvider.select((s) => s.enabled));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(l10n.profileSecurity),
        SwitchListTile(
          secondary: const Icon(Icons.lock_outline),
          title: Text(l10n.profileAppLock),
          subtitle: Text(l10n.profileAppLockSubtitle),
          value: enabled,
          onChanged: (on) async {
            final messenger = ScaffoldMessenger.of(context);
            final result = await ref
                .read(appLockProvider.notifier)
                .setEnabled(on, reason: l10n.lockReasonSettings);
            if (result == AppLockChange.unavailable) {
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.profileAppLockUnavailable)),
              );
            }
          },
        ),
      ],
    );
  }
}
