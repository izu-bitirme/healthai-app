import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healthai/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> notifications = [
    "Your cleaner will arrive at 10:00 AM",
    "You’ve earned a 20% discount!",
    "New plumbing services added near you"
  ];

  final List<Map<String, String>> professionals = [
    {"name": "Alice", "role": "Cleaner"},
    {"name": "Mark", "role": "Plumber"},
    {"name": "Lina", "role": "Electrician"},
  ];

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric( vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 16.0 , vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage("assets/images/auth/profile.png"),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Good Morning 👋", style: TextStyle(fontSize: 14, color: Colors.grey)),
                            Text("Andrew Ainsley", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.notifications_none),
                        SizedBox(width: 12),
                        Icon(Icons.chat_bubble_outline),
                      ],
                    )
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
                  items: notifications.map((msg) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(Icons.notifications, color: Colors.deepPurple),
                                const SizedBox(width: 10),
                                Expanded(child: Text(msg, style: const TextStyle(color: Colors.deepPurple))),
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
                padding: const EdgeInsets.symmetric( horizontal: 16.0 , vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Special Offers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All", style: TextStyle(color: Colors.deepPurple)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 16.0 , vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.purple.shade400, Colors.deepPurple]),
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
                                Text("30%", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text("Today's Special!", style: TextStyle(fontSize: 18, color: Colors.white)),
                                SizedBox(height: 8),
                                Text("Get discount for every order, only valid for today", style: TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        Image.network(
                          "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
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
                padding: const EdgeInsets.symmetric( horizontal: 16.0 , vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All", style: TextStyle(color: Colors.deepPurple)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 16.0 , vertical: 8),
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    serviceIcon(Icons.cleaning_services, "Cleaning"),
                    serviceIcon(Icons.handyman, "Repairing"),
                    serviceIcon(Icons.format_paint, "Painting"),
                    serviceIcon(Icons.local_laundry_service, "Laundry"),
                    serviceIcon(Icons.devices_other, "Appliance"),
                    serviceIcon(Icons.plumbing, "Plumbing"),
                    serviceIcon(Icons.local_shipping, "Shifting"),
                    serviceIcon(Icons.more_horiz, "More"),
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
