import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/pages/home_page.dart';
import 'package:healthai/pages/patient/data_page.dart';
import 'package:healthai/pages/settings.dart';
import 'package:healthai/pages/socket/doctors_page.dart';
import 'package:healthai/pages/tasks/task_page.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  final iconList = [
    HugeIcons.strokeRoundedHome11,
    HugeIcons.strokeRoundedCalendar02,
    HugeIcons.strokeRoundedMessage02,
    HugeIcons.strokeRoundedUser,
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [HomePage(), TaskPage(), MyDoctors(), SettingsScreen()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/welcome-chat");
        },
        backgroundColor: AppColors.primaryColor,
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedChatGpt,
          size: 35,
          color: AppColors.primaryColorLight,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: Colors.white,
        itemCount: iconList.length,
        tabBuilder: (index, isActive) {
          return HugeIcon(
            icon: iconList[index],
            color: isActive ? AppColors.primaryColor : AppColors.iconColorGray,
          );
        },
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => _onTap(index),
      ),
    );
  }
}
