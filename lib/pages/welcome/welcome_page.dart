import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/constants/app_icons.dart';
import 'package:healthai/constants/welcome_data.dart';
import 'package:healthai/screens/home_screen.dart';
import 'package:healthai/screens/welcome_screen.dart';
import 'package:heroicons/heroicons.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  void nextPage() {
    if (currentIndex < contentList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.02;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  contentList.length,
                  (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 2,
                      ), 
                      height: 4, 
                      decoration: BoxDecoration(
                        color:
                            index < currentIndex + 1
                                ? AppColors
                                    .primaryColor 
                                : AppColors.primaryColorLight, 
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  itemCount: contentList.length,
                  itemBuilder: (context, index) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        key: ValueKey<int>(index),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contentList[index]['title']!,
                            style: const TextStyle(
                              fontSize: 30,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            contentList[index]['description']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textColorLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: screenWidth,
                            height: screenHeight * 0.4,
                            child: Image.asset(contentList[index]['image']!),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 35,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        onPressed: previousPage,
                        icon: HeroIcon(
                          size: 32,
                          HeroIcons.chevronLeft,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        onPressed: nextPage,
                        icon: HeroIcon(
                          size: 32,
                          HeroIcons.chevronRight,
                          color: AppColors.primaryColor,
                        ),
                      ),
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
}
