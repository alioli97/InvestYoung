import 'package:material_ui/material_ui.dart';

/// "Label ……… value" line that wraps the value onto a new line when both
/// do not fit (large text sizes), instead of overflowing.
class LabelValueRow extends StatelessWidget {
  const LabelValueRow({super.key, required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [Text(label), value],
      ),
    ),
  );
}
