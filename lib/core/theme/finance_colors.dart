import 'package:material_ui/material_ui.dart';

/// Colors for gains and losses, which Material 3 does not define.
@immutable
class FinanceColors extends ThemeExtension<FinanceColors> {
  const FinanceColors({required this.positive, required this.negative});

  static const light = FinanceColors(
    positive: Color(0xFF1B7F3B),
    negative: Color(0xFFBA1A1A),
  );

  static const dark = FinanceColors(
    positive: Color(0xFF7BDA8F),
    negative: Color(0xFFFFB4AB),
  );

  final Color positive;
  final Color negative;

  /// Color for a signed amount (neutral `null` for zero).
  Color? forSign(num value) => value > 0
      ? positive
      : value < 0
      ? negative
      : null;

  static FinanceColors of(BuildContext context) =>
      Theme.of(context).extension<FinanceColors>() ?? light;

  @override
  FinanceColors copyWith({Color? positive, Color? negative}) => FinanceColors(
    positive: positive ?? this.positive,
    negative: negative ?? this.negative,
  );

  @override
  FinanceColors lerp(FinanceColors? other, double t) {
    if (other == null) return this;
    return FinanceColors(
      positive: Color.lerp(positive, other.positive, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
    );
  }
}
