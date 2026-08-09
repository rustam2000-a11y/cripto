import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../home/data/models/price_point.dart';
import '../presentation/app_colors.dart';

class CoinPriceChart extends StatelessWidget {
  const CoinPriceChart({
    super.key,
    required this.points,
    required this.isLoading,
  });

  final List<PricePoint> points;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 200,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text(
                  'Нет данных для графика',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
        ),
      );
    }

    final spots = [
      for (var i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), points[i].price),
    ];
    final prices = points.map((p) => p.price);
    final minY = prices.reduce((a, b) => a < b ? a : b);
    final maxY = prices.reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.1;
    final isPositive = points.last.price >= points.first.price;
    final lineColor = isPositive ? AppColors.positive : AppColors.negative;

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: LineChart(
        LineChartData(
          minY: minY - padding,
          maxY: maxY + padding,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: false),
          lineTouchData: LineTouchData(
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((_) {
                return TouchedSpotIndicatorData(
                  FlLine(color: lineColor, strokeWidth: 1),
                  FlDotData(
                    getDotPainter: (spot, percent, bar, index) =>
                        FlDotCirclePainter(
                          radius: 4,
                          color: lineColor,
                          strokeWidth: 0,
                        ),
                  ),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => AppColors.cardBackground,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    '\$${spot.y.toStringAsFixed(2)}',
                    const TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: lineColor,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: lineColor.withOpacity(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
