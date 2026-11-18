import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/formatters.dart';
import '../../../../core/l10n/l10n.dart';
import '../../domain/retirement_projection.dart';

/// Projected value vs. contributed capital until retirement.
class RetirementChart extends StatelessWidget {
  const RetirementChart({super.key, required this.projection});

  final RetirementProjection projection;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final valueColor = theme.colorScheme.primary;
    final contributedColor = theme.colorScheme.tertiary;
    final points = projection.points;
    final maxY = points.map((p) => p.valueCents).reduce(math.max).toDouble();
    final startAge = projection.startAge;

    String xLabel(double month) {
      final years = (month / 12).round();
      return startAge == null ? '${years}a' : '${startAge + years}';
    }

    LineChartBarData line(
      List<FlSpot> spots,
      Color color, {
      bool dashed = false,
    }) => LineChartBarData(
      spots: spots,
      color: color,
      barWidth: 3,
      isCurved: true,
      preventCurveOverShooting: true,
      dashArray: dashed ? [6, 4] : null,
      dotData: const FlDotData(show: false),
    );

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                l10n.goalsProjectionTitle,
                style: theme.textTheme.titleMedium,
              ),
            ),
            // Screen readers get the summary in the legend below instead.
            ExcludeSemantics(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: maxY * 1.05,
                    minX: 0,
                    maxX: points.last.month.toDouble(),
                    gridData: const FlGridData(drawVerticalLine: false),
                    borderData: FlBorderData(show: false),
                    lineTouchData: const LineTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 56,
                          getTitlesWidget: (value, meta) => SideTitleWidget(
                            meta: meta,
                            child: Text(
                              context.formatCompactCurrency(value.round()),
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: math
                              .max(12, (points.last.month / 4 / 12).ceil() * 12)
                              .toDouble(),
                          getTitlesWidget: (value, meta) => SideTitleWidget(
                            meta: meta,
                            child: Text(
                              xLabel(value),
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                    lineBarsData: [
                      line(
                        [
                          for (final p in points)
                            FlSpot(
                              p.month.toDouble(),
                              p.contributedCents.toDouble(),
                            ),
                        ],
                        contributedColor,
                        dashed: true,
                      ),
                      line([
                        for (final p in points)
                          FlSpot(p.month.toDouble(), p.valueCents.toDouble()),
                      ], valueColor),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _Legend(
              color: valueColor,
              label: l10n.goalsProjectionValue(
                context.formatCurrency(projection.last.valueCents),
              ),
            ),
            _Legend(
              color: contributedColor,
              dashed: true,
              label: l10n.goalsProjectionContributed(
                context.formatCurrency(projection.last.contributedCents),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.goalsProjectionAssumption(
                context.formatCurrency(projection.monthlyCents),
              ),
              style: theme.textTheme.bodySmall,
            ),
            Text(
              l10n.commonSimulationDisclaimer,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    required this.color,
    required this.label,
    this.dashed = false,
  });

  final Color color;
  final String label;
  final bool dashed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 4,
          decoration: BoxDecoration(
            color: dashed ? null : color,
            border: dashed
                ? Border(top: BorderSide(color: color, width: 3))
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ],
    ),
  );
}
