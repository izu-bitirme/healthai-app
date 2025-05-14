import 'package:flutter/material.dart';

class HealthCard extends StatelessWidget {
  const HealthCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Büyük ve dikkat çekici insan vücudu görseli
            SizedBox(
              width: 150,
              height: 200,
              child: Image.asset(
                'assets/images/body.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 20),
            // Sağ taraftaki bilgiler
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      InfoColumn(label: 'Height', value: '178 cm'),
                      SizedBox(width: 32),
                      InfoColumn(label: 'Weight', value: '70 kg'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      InfoColumn(label: 'Water', value: '43%'),
                      SizedBox(width: 32),
                      InfoColumn(label: 'Sleep', value: '7h 30m'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const InfoColumn({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}
