import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconButton iconButton;
  final Color bgColor;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.iconButton,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.amber,
      child: Row(
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedBackward02,
            color: AppColors.iconColorGray,
          ),
          Text("Profile"),
          HugeIcon(
            icon: HugeIcons.strokeRoundedMenu02,
            color: AppColors.cardPrimaryColor,
          ),
        ],
      ),
    );
  }
}
