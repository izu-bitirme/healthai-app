import 'package:flutter/material.dart';
import 'package:healthai/pages/tasks/task_card.dart';
import 'package:healthai/pages/tasks/task_statu.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

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
            child: TaskCardItem(
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
            child: TaskCardItem(
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
            child: const TaskCardItem(
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
            child: const TaskCardItem(
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
