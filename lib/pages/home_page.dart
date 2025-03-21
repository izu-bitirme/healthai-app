import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/pages/tasks/charts/charts.dart';
import 'package:healthai/pages/tasks/my_task.dart';
import 'package:healthai/pages/tasks/task_statu.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              const SizedBox(height: 20),
              const HeaderText(),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const TaskOverviewCard(),
              const SizedBox(height: 20),
              SectionTitle(title: 'In Progress'),
              TaskList(),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyTasksPage()),
              ),

          child: HugeIcon(
            icon: HugeIcons.strokeRoundedChart01,
            color: AppColors.textColor,
            size: 28,
          ),
        ),
        Text(
          'Health AI',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        HugeIcon(
          icon: HugeIcons.strokeRoundedNotification01,
          color: AppColors.textColor,
          size: 26,
        ),
      ],
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Let's make task together 🙌",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}

class TaskOverviewCard extends StatelessWidget {
  const TaskOverviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Application Design",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "UI Design Kit",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Spacer(),
              const Text(
                "Progress 50/80",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 50 / 80,
            backgroundColor: Colors.white24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002055),
          ),
        ),
        const Spacer(),
        HugeIcon(
          icon: HugeIcons.strokeRoundedArrowRight01,
          color: AppColors.primaryColor,
          size: 26,
        ),
      ],
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
           InkWell(
             onTap:
                 () => Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => TaskProgressPage()),
             ),
             child: TaskCard(
              title: 'Create Detail Booking',
              subtitle: 'Productivity Mobile App',
              time: '2 min ago',
              percent: 0.6,
                       ),
           ),
          InkWell(
            onTap:
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskProgressPage()),
            ),
            child: TaskCard(
            title: 'Revision Home Page',
            subtitle: 'Banking Mobile App',
            time: '5 min ago',
            percent: 0.7,
          ),
          ),
          InkWell(
            onTap:
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskProgressPage()),
            ),
            child: const TaskCard(
              title: 'Working On Landing Page',
              subtitle: 'Online Course',
              time: '7 min ago',
              percent: 0.8,
            ),
          ),
          InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskProgressPage()),
                ),
            child: const TaskCard(
              title: 'Working On Landing Page',
              subtitle: 'Online Course',
              time: '7 min ago',
              percent: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final double percent;

  const TaskCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.percent,
  }) : super(key: key);

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
