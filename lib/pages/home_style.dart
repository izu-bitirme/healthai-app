import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/pages/tasks/my_task.dart';
import 'package:healthai/providers/profile_provider.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> notifications = [
    "Your cleaner will arrive at 10:00 AM",
    "You’ve earned a 20% discount!",
    "New plumbing services added near you",
  ];

  final List<Map<String, String>> professionals = [
    {"name": "Alice", "role": "Cleaner"},
    {"name": "Mark", "role": "Plumber"},
    {"name": "Lina", "role": "Electrician"},
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
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
                            Text(
                              "Welcome Back 👋",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              profileProvider.profile?.username ?? "",
                              style: TextStyle(
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
                        Text(
                          'Health AI',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedNotification01,
                          color: AppColors.textColor,
                          size: 26,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 50,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.0,
                  ),
                  items:
                      notifications.map((msg) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
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
                          },
                        );
                      }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Special Offers
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Special Offers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("See All", style: TextStyle(color: Colors.deepPurple)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: ClipRRect(
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
                        Image.network(
                          "https://w7.pngwing.com/pngs/678/191/png-transparent-stethoscope-healthcare-health-hospital-medicine-care-3d-icon-thumbnail.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Services
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("See All", style: TextStyle(color: Colors.deepPurple)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    serviceIcon(Icons.cleaning_services, "Cleaning"),
                    serviceIcon(Icons.handyman, "Repairing"),
                    serviceIcon(Icons.format_paint, "Painting"),
                    serviceIcon(Icons.local_laundry_service, "Laundry"),
                    
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.deepPurple),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
