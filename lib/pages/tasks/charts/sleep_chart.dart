import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SleepMetricsWidget extends StatelessWidget {
  final double sleepHours;
  final int filledDots;
  final int totalDots;

  const SleepMetricsWidget({
    Key? key,
    required this.sleepHours,
    this.totalDots = 24,
    required this.filledDots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:8, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedSleeping, color: Colors.blueAccent, size: 26),
                const SizedBox(width: 5),
                Text(
                  sleepHours.toStringAsFixed(1), // 9.1 formatında gösterim
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  " hour",
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(totalDots, (index) {
                return CircleAvatar(
                  radius: 6,
                  backgroundColor: index < filledDots ? Colors.blueAccent : Colors.grey[300],
                );
              }),
            ),
            const SizedBox(height: 12),

            // Açıklama Metni
            Text(
              "Be sure to log your sleep metrics everyday!",
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
