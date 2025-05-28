// pages/doctors.dart
import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/models/auth/user.dart';
import 'package:healthai/pages/socket/chat.dart';
import 'package:healthai/providers/doctor.dart';
import 'package:healthai/providers/user_provider.dart';
import 'package:healthai/screens/call_screen.dart';
import 'package:healthai/services/chat.dart';
import 'package:healthai/widgets/custom_app_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:healthai/providers/socket_chat.dart';
import 'package:healthai/models/doctor.dart';

class MyDoctors extends StatelessWidget {
  const MyDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(title: "My Doctors", bgColor: AppColors.primaryColor),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Consumer<DoctorProvider>(
                builder: (context, provider, _) {
                  if (provider.doctors.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.doctors.length,
                    itemBuilder: (context, index) {
                      final DoctorModel doctor = provider.doctors[index];
                      final doctorId =
                          doctor.id ?? 0; // Provide default value if null
                      final doctorName =
                          doctor.fullName ??
                          doctor.username ??
                          'Unknown Doctor';
                      final doctorImage = doctor.image ?? "";

                      return ChangeNotifierProvider(
                        create:
                            (_) => ChatProvider(
                              userId: 1,
                              receiverId: doctorId,
                              roomName: 'room_1_$doctorId',
                            ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
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
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                  doctorImage,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctorName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor.specialty ??
                                          'General Practitioner',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "4.8",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (
                                                context,
                                              ) => ChangeNotifierProvider(
                                                create:
                                                    (_) => ChatProvider(
                                                      userId: 1,
                                                      receiverId: doctorId,
                                                      roomName:
                                                          'room_1_$doctorId',
                                                    ),
                                                child: ChatPage(
                                                  doctorId: doctorId,
                                                  doctorName: doctorName,
                                                  doctorImage: doctorImage,
                                                  roomName:
                                                      doctor.username ??
                                                      'chat_room',
                                                ),
                                              ),
                                        ),
                                      );
                                    },
                                    icon: HugeIcon(
                                      icon: HugeIcons.strokeRoundedBubbleChat,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ChatChannel.call(
                                        receiverId: doctorId,
                                        doctorName: doctorName,
                                        context: context,
                                      );
                                    },
                                    icon: HugeIcon(
                                      icon: HugeIcons.strokeRoundedCall,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
