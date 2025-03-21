import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class TaskProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, color: AppColors.textColor, size: 24.0,)),
                  Text(
                    'Task Status',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.tune),
                ],
              ),
              SizedBox(height: 20),
              MultiProgressCircularIndicator(),
        
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Indicator(color: Colors.green, text: 'To Do'),
                  SizedBox(width: 10),
                  Indicator(color: Colors.orange, text: 'In Progress'),
                  SizedBox(width: 10),
                  Indicator(color: Colors.blue, text: 'Completed'),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                   InkWell(
                    onTap: () => Navigator.pushNamed(context, "/task-detail"),
                    child: TaskCard(title: 'Completed', taskInfo: '18 Task now - 18 Task Completed', borderColor: Colors.blue)),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, "/task-detail"),
                      child: TaskCard(title: 'In Progress', taskInfo: '2 Task now - 1 started', borderColor: Colors.orange)),
                    InkWell(
                      onTap :() =>Navigator.pushNamed(context, '/task-detail') ,
                      child: TaskCard(title: 'To Do', taskInfo: '2 Task now - 1 Upcoming', borderColor: Colors.green)),
                  ],
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String taskInfo;
  final Color borderColor;

  TaskCard({required this.title, required this.taskInfo, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(taskInfo),
        trailing: Icon(Icons.more_horiz),
      ),
    );
  }
}


class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  Indicator({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}


class MultiProgressCircularIndicator extends StatelessWidget {
  const MultiProgressCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularPercentIndicator(
          radius: 100.0,
          lineWidth: 20.0,
          percent: 1.0, // Tam daire
          progressColor: const Color.fromARGB(255, 28, 182, 61).withOpacity(0.3), // Bekleyen kısım
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.transparent,
        ),
        CircularPercentIndicator(
          radius: 100.0,
          lineWidth: 20.0,
          percent: 0.70, // Tamamlanan ve ilerleyen kısmı kapsar
          progressColor: Colors.orange.shade400, // Tamamlanan kısım
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.transparent,
        ),
        CircularPercentIndicator(
          radius: 100.0,
          lineWidth:20.0,
          percent: 0.20, // Sadece ilerleme kısmını gösterir
          progressColor: AppColors.cardPrimaryColor, // İlerleme
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.transparent,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '70%', // Ana ilerleme yüzdesi
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Complete'),
          ],
        ),
      ],
    );
  }
}