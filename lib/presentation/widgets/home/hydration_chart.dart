import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HydrationLineChart extends StatelessWidget {
  final double progress; // 0.0 to 1.0 — for future water fill
  const HydrationLineChart({super.key, this.progress = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 1,
            minY: 0,
            maxY: 2,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 0.25,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white12,
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    if (value == 0) {
                      return const Text(
                        '0L',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    } else if (value == 2) {
                      return const Text(
                        '2L',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 60,
                  getTitlesWidget: (value, meta) {
                    if (value == 0) {
                      return Text(
                        '${(2 * progress * 1000).toInt()}ml',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.white24, width: 2),
                bottom: BorderSide(color: Colors.white24, width: 2),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: false,
                color: const Color(0xFF4AB0FF),
                spots: [
                  const FlSpot(0.15, 0),
                  FlSpot(0.15, 2 * progress),
                ],
                barWidth: 8,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    if (index == 1 && progress > 0) {
                      return FlDotCirclePainter(
                        radius: 6,
                        color: const Color(0xFF4AB0FF),
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      );
                    }
                    return FlDotCirclePainter(
                      radius: 0,
                      color: Colors.transparent,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
