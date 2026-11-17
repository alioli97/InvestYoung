// Parsing and formatting of euro amounts typed by the user (es/ca style).

/// Parses a euro amount into cents, or returns `null` if it is not valid.
///
/// Accepts `1234`, `1234,5`, `1.234,56`, `1234.56` and an optional `€`.
/// A `.` is a decimal separator only when there is no `,` and it is followed
/// by 1–2 digits; otherwise dots are thousands separators. Negative amounts
/// are rejected. An empty string returns `null`.
int? parseEurosToCents(String input) {
  var text = input.replaceAll(RegExp(r'[\s  €]'), '');
  if (text.isEmpty) return null;

  if (text.contains(',')) {
    text = text.replaceAll('.', '').replaceAll(',', '.');
  } else if (!RegExp(r'^\d+\.\d{1,2}$').hasMatch(text)) {
    text = text.replaceAll('.', '');
  }

  final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(text);
  if (match == null) return null;
  final euros = int.parse(match.group(1)!);
  final decimals = (match.group(2) ?? '').padRight(2, '0');
  return euros * 100 + int.parse(decimals);
}

/// Formats [cents] for an input field: no symbol, no grouping, comma decimals
/// only when needed (`60000` → `600`, `60050` → `600,50`).
String formatCentsForInput(int cents) {
  final euros = cents ~/ 100;
  final rest = cents % 100;
  return rest == 0 ? '$euros' : '$euros,${rest.toString().padLeft(2, '0')}';
}

/// Parses a percentage typed by the user (`2,5`, `2.5`, `2,5 %`) into a
/// ratio (`0.025`). Returns `null` when empty or invalid. Negative values are
/// allowed (e.g. negative yields).
double? parsePercentToRatio(String input) {
  final text = input
      .replaceAll(RegExp(r'[\s\u00A0\u202F%]'), '')
      .replaceAll(',', '.');
  if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(text)) return null;
  return double.parse(text) / 100;
}

/// Formats a ratio for an input field (`0.025` → `2,5`).
String formatRatioForInput(double ratio) {
  final percent = (ratio * 100 * 10000).round() / 10000;
  final text = percent == percent.truncateToDouble()
      ? percent.toInt().toString()
      : percent.toString();
  return text.replaceAll('.', ',');
}
