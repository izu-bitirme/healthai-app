import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskCardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final double percent;

  const TaskCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textColorGray,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColors.textColorGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 5.0,
              percent: percent,
              center: Text("${(percent * 100).toInt()}%"),
              progressColor: AppColors.primaryColor,
              backgroundColor: Color(0xFFD1E2FE),
            ),
          ],
        ),
      ),
    );
  }
}
