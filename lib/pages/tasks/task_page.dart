import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:healthai/constants/app_colors.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DateTime _selectedDate = DateTime.now();
  bool _showFullCalendar = false;
  
  

  final List<Map<String, dynamic>> _tasks = [
    {
      "date": DateTime(2025, 3, 21),
      "time": "10 am",
      "title": "Wireframe elements 😌",
      "duration": "10am - 11am",
      "color": Colors.blue,
    },
    {
      "date": DateTime(2025, 3, 21),
      "time": "12 pm",
      "title": "Mobile app Design 😍",
      "duration": "11:40am - 12:40pm",
      "color": Colors.green,
    },
    {
      "date": DateTime(2025, 3, 22),
      "time": "01 pm",
      "title": "Design Team call 🙋‍♂️",
      "duration": "01:20pm - 02:20pm",
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTasks =
        _tasks.where((task) => isSameDay(task['date'], _selectedDate)).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft01,
                      color: AppColors.textColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Today Task",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedCalendar02,
                      color: AppColors.textColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _showFullCalendar = !_showFullCalendar;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "${_selectedDate.month}, ${_selectedDate.day} ✍",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "${filteredTasks.length} tasks today",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              _showFullCalendar ? _buildFullCalendar() : _buildScrollableDays(),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    var task = filteredTasks[index];
                    return _taskCard(
                      task["time"],
                      task["title"],
                      task["duration"],
                      task["color"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildScrollableDays() {
  // Calculate the start date once, to avoid repeated calculations in the loop
  DateTime startDate = _selectedDate.subtract(Duration(days: 3));

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(7, (index) {
        DateTime date = startDate.add(Duration(days: index));
        bool isSelected = isSameDay(date, _selectedDate);

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = date;
            });
          },
          child: _dateWidget(
            date.day.toString(),
            _getWeekday(date.weekday),
            isSelected,
          ),
        );
      }),
    ),
  );
}

Widget _buildFullCalendar() {
  return Card(
    color: Colors.white,
    elevation: 0.5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfCalendar(
        view: CalendarView.month,
        backgroundColor: Colors.white,
        todayHighlightColor: Colors.transparent,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle, // Removed borderRadius here to avoid conflict
        ),
        headerStyle: CalendarHeaderStyle(
          backgroundColor: Colors.white,
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        onTap: (CalendarTapDetails details) {
          if (details.date != null) {
            setState(() {
              _selectedDate = details.date!;
              _showFullCalendar = false;
            });
          }
        },
        monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
          showAgenda: false,
          monthCellStyle: MonthCellStyle(
            textStyle: TextStyle(fontSize: 16, color: Colors.black87),
            leadingDatesTextStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            trailingDatesTextStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            todayBackgroundColor: Colors.transparent,
            leadingDatesBackgroundColor: Colors.transparent,
            trailingDatesBackgroundColor: Colors.transparent,
          ),
        ),
        headerHeight: 60,
        cellBorderColor: Colors.transparent,
        showNavigationArrow: true,
        showDatePickerButton: true,
        initialSelectedDate: _selectedDate,
        todayTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        headerDateFormat: 'dd MMM yyyy',
        viewHeaderStyle: ViewHeaderStyle(
          backgroundColor: Colors.white,
          dayTextStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}


  Widget _dateWidget(String day, String weekday, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : AppColors.cardGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            weekday,
            style: TextStyle(
              fontSize: 12,
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

  String _getWeekday(int day) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[day - 1];
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
