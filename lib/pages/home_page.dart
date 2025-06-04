import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/pages/emotion/emotion_page.dart';
import 'package:healthai/pages/patient/data_page.dart';
import 'package:healthai/pages/tasks/charts/drink_track.dart';
import 'package:healthai/pages/tasks/charts/health_card.dart';
import 'package:healthai/pages/tasks/charts/sleep_chart.dart';
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

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Postoperative Recovery Tracker",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${90 - profileProvider.profile!.daysLeft}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " days remaining",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            LinearProgressIndicator(
                              value:
                                  (90 - profileProvider.profile!.daysLeft) / 90,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: Colors.white24,
                              color: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.greenAccent.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Day ${profileProvider.profile?.daysLeft}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Day 90",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // 3D Hasta Modeli için alan
                      Container(
                        width: 130,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Center(
                          child:
                              Image.asset(
                                'assets/images/paitions.png',
                                fit: BoxFit.cover,
                              ) ??
                              Icon(
                                Icons.medical_services,
                                size: 60,
                                color: Colors.white.withOpacity(0.3),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryColorLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AI Avatar
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/chatbot.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),

                      // Chat Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "AI Recommendation",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColorLight,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "ONLINE",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "İyileşme sürecinizde size yardımcı rehberlik edebilirim. Hadi konuşalım! 💬",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildActionChip(
                                    "Beslenme Önerileri",
                                    Icons.restaurant,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionChip(
                                    "Egzersiz Programı",
                                    Icons.directions_run,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionChip(
                                    "Ağrı Yönetimi",
                                    Icons.medical_services,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionChip(
                                    "Uyku Düzeni",
                                    Icons.bedtime,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

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
                      "Task Progress",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskProgressPage(),
                        ),
                      ),
                    ), // Changed to construction icon for handyman

                    serviceIcon(
                      HugeIcons.strokeRoundedZoomSquare,
                      "Data Collection",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataCollectionScreen(),
                        ),
                      ),
                    ), //
                    serviceIcon(
                      HugeIcons.strokeRoundedZoomSquare,
                      "Task List",
                      () {},
                    ), //
                  ],
                ),

                const SizedBox(height: 24),

                sectionTitle("Body Health"),
                const SizedBox(height: 12),
                HealthCard(),
                const SizedBox(height: 12),
                Divider(height: 1, color: Colors.grey[300]),
                const SizedBox(height: 16),
                SleepMetricsWidget(
                  sleepHours: 9.1,
                  totalDots: 30,
                  filledDots: 25,
                ),
                const SizedBox(height: 24),

                DrinkTrackWidget(),
                const SizedBox(height: 24),
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

Widget _buildActionChip(String text, IconData icon) {
  return Chip(
    avatar: Icon(icon, size: 18, color: AppColors.primaryColor),
    label: Text(text),
    labelStyle: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    backgroundColor: AppColors.primaryColorLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: AppColors.primaryColor.withOpacity(0.1),
        width: 1,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  );
}
