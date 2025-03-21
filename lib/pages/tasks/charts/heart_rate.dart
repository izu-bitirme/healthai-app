import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class HeartRateWidget extends StatelessWidget {
  final List<FlSpot> heartRateData = [
    FlSpot(0, 80),
    FlSpot(1, 75),
    FlSpot(2, 78),
    FlSpot(3, 74),
    FlSpot(4, 76),
    FlSpot(5, 72),
    FlSpot(6, 70),
  ]; // Kalp atış hızı verileri

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red.shade400),
                    SizedBox(width: 6),
                    Text(
                      'Heart Rate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textColorGray,
                      ),
                    ),
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowRight01,
                      color: AppColors.textColorGray,
                      size: 26,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '72 bpm',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Resting Rate',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 80,
                  width: 160,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                              return Text(
                                days[value.toInt()],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: heartRateData,
                          isCurved: true,
                          gradient: LinearGradient(
                            colors: [Colors.red.shade700, Colors.red.shade100],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.withOpacity(0.1),
                                Colors.white,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],

                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => Colors.red.shade300, // Tooltip arka plan rengi
                          tooltipRoundedRadius: 8, // Kenar yuvarlaklığı
                          tooltipPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              return LineTooltipItem(
                                '${spot.y.toInt()} bpm', // Dokunulan noktadaki değeri göster
                                TextStyle(
                                  color: Colors.white, // Yazı rengi
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
