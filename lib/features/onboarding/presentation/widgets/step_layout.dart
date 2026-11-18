import 'package:material_ui/material_ui.dart';

/// Scrollable body shared by every onboarding step: title, subtitle, content.
class StepLayout extends StatelessWidget {
  const StepLayout({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      children: [
        Text(title, style: textTheme.headlineSmall),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(subtitle!, style: textTheme.bodyMedium),
        ],
        const SizedBox(height: 24),
        ...children,
      ],
    );
  }
}

/// Small section heading inside a step.
class StepSectionLabel extends StatelessWidget {
  const StepSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}
