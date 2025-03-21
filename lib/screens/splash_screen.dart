import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthai/pages/welcome/welcome_page.dart';
import 'package:healthai/screens/home_screen.dart';
import 'package:healthai/services/app_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.5; 
  double _opacity = 0.0; 

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _scale = 1.2; 
        _opacity = 1.0;
      });
    });

    AppStatus.isFirstOpen().then((bool isFirstOpen) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => isFirstOpen ? WelcomePage() : HomeScreen()), 
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _scale, 
                duration: const Duration(milliseconds: 800), 
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 800), 
                  child: Image.asset(
                    'assets/images/app-icon.png', 
                    width: 75,
                    height: 75,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedScale(
                scale: _scale,  
                duration: const Duration(milliseconds: 800),  
                curve: Curves.easeInOut,  
                child: AnimatedOpacity(
                  opacity: _opacity,  
                  duration: const Duration(milliseconds: 800),  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'HealthAI', 
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
