

import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002055),
          ),
        ),
        const Spacer(),
        HugeIcon(
          icon: HugeIcons.strokeRoundedArrowRight01,
          color: AppColors.primaryColor,
          size: 26,
        ),
      ],
    );
  }
}
