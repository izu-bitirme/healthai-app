import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthai/pages/auth/login_page.dart';
import 'package:healthai/pages/welcome/welcome_page.dart';
import 'package:healthai/providers/doctor.dart';
import 'package:healthai/providers/message_provider.dart';
import 'package:healthai/providers/profile_provider.dart';
import 'package:healthai/providers/task.dart';
import 'package:healthai/providers/user_provider.dart';
import 'package:healthai/screens/home_screen.dart';
import 'package:healthai/services/app_status.dart';
import 'package:healthai/services/chat.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.5;
  double _opacity = 0.0;
  bool fetched = false;
  final islogin = AppStatus.isLogin();

  Future<void> _fetchInitialData() async {
    try {
      final MessageProvider messageProvider = Provider.of<MessageProvider>(
        context,
        listen: false,
      );
      await ChatChannel.init();
      ChatChannel.addListener('chat_message', messageProvider.onMessage);
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final doctorProvider = Provider.of<DoctorProvider>(
        context,
        listen: false,
      );
      final userProvider = Provider.of<AuthProvider>(context, listen: false);

      await profileProvider.fetchProfile();
      await doctorProvider.fechDoctors();
      await taskProvider.fetchTasks();
      fetched = true;
    } catch (err) {
      print("Hata: $err");
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchInitialData().then((_) => {checkAppStatus()});

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _scale = 1.2;
        _opacity = 1.0;
      });
    });
  }

  void checkAppStatus() async {
    bool isFirstOpen = await AppStatus.isFirstOpen();
    bool isLoggedIn = await AppStatus.isLogin();

    Timer(Duration(seconds: 2), () {
      Widget nextPage;

      if (isFirstOpen) {
        nextPage = WelcomePage();
      } else if (isLoggedIn) {
        nextPage = HomeScreen();
      } else {
        nextPage = LoginPage();
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);

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
                    'assets/app-icon.png',
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
