import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/widgets/custom_app_bar.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

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
              CustomAppBar(
                title: "Today Task",
                bgColor: Colors.white,
                textColor: Colors.black,
                leadingIcon: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context); // veya özel işlem
                    }
                  },
                ),
                trailingIcon: const SizedBox(
                  width: 10,
                ), // Sağda boşluk isteniyordu
              ),

              SizedBox(height: 10),
              Text(
                "October, 20 ✍",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text("15 task today", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _dateWidget("19", "Sat", false),
                  _dateWidget("20", "Sun", true),
                  _dateWidget("21", "Mon", false),
                  _dateWidget("22", "Tue", false),
                  _dateWidget("23", "Wed", false),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    _taskCard(
                      "10 am",
                      "Wireframe elements 😌",
                      "10am - 11am",
                      Colors.blue,
                    ),
                    _taskCard(
                      "12 pm",
                      "Mobile app Design 😍",
                      "11:40am - 12:40pm",
                      Colors.green,
                    ),
                    _taskCard(
                      "01 pm",
                      "Design Team call 🙋‍♂️",
                      "01:20pm - 02:20pm",
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateWidget(String day, String weekday, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            weekday,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskCard(String time, String title, String duration, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    duration,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
