import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(child: Center(child: Text('Go to Second Page'))),
    );
  }
}
