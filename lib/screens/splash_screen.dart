import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthai/pages/welcome/welcome_page.dart';
import 'package:healthai/screens/home_screen.dart';
import 'package:healthai/screens/welcome_screen.dart';
import 'package:healthai/services/app_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.5; // Başlangıçta küçük
  double _opacity = 0.0; // Başlangıçta opaklık sıfır

  @override
  void initState() {
    super.initState();

    // Animasyon başlangıcı
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _scale = 1.2; // Daha hızlı büyüme için biraz daha büyük
        _opacity = 1.0; // Opaklık görünür olacak
      });
    });

    AppStatus.isFirstOpen().then((bool isFirstOpen) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => isFirstOpen ? WelcomeScreen() : HomeScreen()), 
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
                scale: _scale, // Skalayı animasyonla değiştir
                duration: const Duration(milliseconds: 800), // Daha hızlı büyüme
                curve: Curves.easeInOut, // Akıcı geçiş için
                child: AnimatedOpacity(
                  opacity: _opacity, // Opaklık animasyonu
                  duration: const Duration(milliseconds: 800), // Hızlı geçiş
                  child: Image.asset(
                    'assets/images/app-icon.png', // Logo
                    width: 75,
                    height: 75,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedScale(
                scale: _scale, // Skalayı animasyonla değiştir
                duration: const Duration(milliseconds: 800), // Daha hızlı büyüme
                curve: Curves.easeInOut, // Akıcı geçiş için
                child: AnimatedOpacity(
                  opacity: _opacity, // Opaklık animasyonu
                  duration: const Duration(milliseconds: 800), // Hızlı geçiş
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'HealthAI', // Uygulama adı
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
