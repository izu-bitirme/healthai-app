import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthai/pages/emotion/today_feeling.dart';

class EmotionPage extends StatefulWidget {
  const EmotionPage({super.key});

  @override
  _EmotionPageState createState() => _EmotionPageState();
}

class _EmotionPageState extends State<EmotionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200), // 1.2 saniye animasyon
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuad, // Yumuşak büyüme efekti
      ),
    );

    _controller.forward();

    Future.delayed(Duration(milliseconds: 1500), () {
      // Toplam 1.5 saniye
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MoodSelector()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: SvgPicture.asset(
                'assets/icons/face.svg',
                width: 100,
                height: 100,
                placeholderBuilder:
                    (context) => SizedBox(width: 100, height: 100),
              ),
            );
          },
        ),
      ),
    );
  }
}
