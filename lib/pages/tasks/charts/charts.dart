import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';


class AsklepiosScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1.5,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(
                          '82.5',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text('Your Asklepios Score', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today, size: 16, color: AppColors.cardPrimaryColor),
                  label: Text('Last 7 days', style: TextStyle(color: AppColors.cardPrimaryColor)),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.5,
                    foregroundColor: AppColors.textColorGray,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(height: 200, child: AsklepiosBarChart()),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_down, color: Colors.red),
                    SizedBox(width: 5),
                    Text('-12% vs last week', style: TextStyle(color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.amber),
                    SizedBox(width: 5),
                    Text('8 insights', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AsklepiosBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                return Text(days[value.toInt()], style: TextStyle(fontSize: 14));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (int i = 0; i < 7; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: (i == 4) ? 8 : (i % 2 == 0 ? 5 : 3),
                  color: Colors.blue.shade700.withOpacity((i == 4) ? 1.0 : 0.5),
                  width: 16,
                ),
              ],
            ),
        ],
      ),
    );
  }
}