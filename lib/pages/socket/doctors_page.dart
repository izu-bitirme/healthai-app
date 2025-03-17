import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/widgets/custom_app_bar.dart';

class MyDoctors extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Rodger Struck',
      'specialty': 'Heart Surgeon, London, England',
      'rating': 4.8,
      'image': 'assets/images/doctor.png',
    },
    {
      'name': 'Dr. Kathy Pacheco',
      'specialty': 'Heart Surgeon, London, England',
      'rating': 4.8,
      'image': 'assets/images/doctor.png',
    },
    {
      'name': 'Dr. Lorri Warf',
      'specialty': 'General Dentist',
      'rating': 4.8,
      'image': 'assets/images/doctor.png',
    },
    {
      'name': 'Dr. Chris Glasser',
      'specialty': 'Heart Surgeon, London, England',
      'rating': 4.8,
      'image': 'assets/images/doctor.png',
    },
    {
      'name': 'Dr. Kenneth Allen',
      'specialty': 'General Dentist',
      'rating': 4.8,
      'image': 'assets/images/doctor.png',
    },
  ];

  MyDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAppBar(title: "My Doctors", bgColor: AppColors.primaryColor),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:  Colors.transparent,
                          backgroundImage: AssetImage(doctor['image']),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                doctor['specialty'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    doctor['rating'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                'Appointment',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.chat_bubble,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
