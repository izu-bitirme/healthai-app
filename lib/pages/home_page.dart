import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/pages/emotion/emotion_page.dart';
import 'package:healthai/pages/patient/data_page.dart';
import 'package:healthai/pages/tasks/charts/health_card.dart';
import 'package:healthai/pages/tasks/my_task.dart';
import 'package:healthai/pages/tasks/task_statu.dart';
import 'package:healthai/providers/notification_provider.dart';
import 'package:healthai/providers/profile_provider.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            profileProvider.profile?.avatar ?? '',
                          ),
                          backgroundColor: AppColors.cardPrimaryColor,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome Back 👋",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              profileProvider.profile?.username ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyTasksPage(),
                                ),
                              ),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedChart01,
                            color: AppColors.textColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedNotification01,
                          color: AppColors.textColor,
                          size: 26,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                // NOTIFICATIONS SLIDER
                CarouselSlider(
                  options: CarouselOptions(
                    height: 50,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.0,
                  ),
                  items:
                      notificationProvider.notifications.map((msg) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.notifications,
                                  color: Colors.deepPurple,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    msg,
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),

                const SizedBox(height: 24),

                // TASK OVERVIEW CARD
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Discharge Days Countdown",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${90 - profileProvider.profile!.daysLeft} days left to discharge",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            "Progress ${profileProvider.profile?.daysLeft}/90",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: profileProvider.profile!.daysLeft / 90,
                        backgroundColor: Colors.white24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // SERVICES GRID
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    serviceIcon(
                      HugeIcons.strokeRoundedHappy,
                      "Emotion Mode",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmotionPage()),
                      ),
                    ), // Changed to more appropriate cleaning icon
                    serviceIcon(
                      HugeIcons.strokeRoundedAccountSetting03,
                      "Water Mode",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskProgressPage(),
                        ),
                      ),
                    ), // Changed to construction icon for handyman
                    serviceIcon(
                      HugeIcons.strokeRoundedAccountSetting03,
                      "Pain Level",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskCardList()),
                      ),
                    ), // More appropriate water icon
                    serviceIcon(
                      HugeIcons.strokeRoundedZoomSquare,
                      "Daily Report",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataCollectionScreen(),
                        ),
                      ),
                    ), //
                  ],
                ),

                const SizedBox(height: 24),

                sectionTitle("Body Health"),
                const SizedBox(height: 12),
                HealthCard(),

                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade400, Colors.deepPurple],
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "30%",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Today's Reports!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Good health starts with good habits",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/health.png',
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                sectionTitle("Today's Tasks"),
                const SizedBox(height: 12),
                TaskCardList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        HugeIcon(
          icon: HugeIcons.strokeRoundedArrowRight01,
          color: AppColors.primaryColor,
          size: 24,
        ),
      ],
    );
  }

  Widget serviceIcon(IconData icon, String label, VoidCallback callback) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(12),
          child: InkWell(
            onTap: callback,
            child: HugeIcon(icon: icon, color: AppColors.cardPrimaryColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class TaskCardList extends StatelessWidget {
  const TaskCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        TaskCard(
          title: 'Create Detail Booking',
          subtitle: 'Productivity Mobile App',
          time: '2 min ago',
          percent: 0.6,
        ),
        TaskCard(
          title: 'Revision Home Page',
          subtitle: 'Banking Mobile App',
          time: '5 min ago',
          percent: 0.7,
        ),
        TaskCard(
          title: 'Working On Landing Page',
          subtitle: 'Online Course',
          time: '7 min ago',
          percent: 0.8,
        ),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final double percent;

  const TaskCard({
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
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
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
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 5.0,
              percent: percent,
              center: Text("${(percent * 100).toInt()}%"),
              progressColor: AppColors.primaryColor,
              backgroundColor: const Color(0xFFD1E2FE),
            ),
          ],
        ),
      ),
    );
  }
}
