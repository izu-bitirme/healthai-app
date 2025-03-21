import 'package:flutter/material.dart';
import 'package:healthai/pages/tasks/charts/drink_track.dart';
import 'package:healthai/pages/tasks/charts/heart_rate.dart';
import 'package:healthai/pages/tasks/charts/sleep_chart.dart';

class MyTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Friday, 26',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Let’s make task together 🌤️.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 16),
              SleepMetricsWidget(sleepHours: 9.1, totalDots: 30, filledDots: 25,),
              DrinkTrackWidget(),
              HeartRateWidget(),
              
               
              
              
            ],
          ),
        ),
      ),
    );
  }
}