import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/constants/app_respons.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color? textColor;
  final Widget? Icon;
  final Widget? linkIcon;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.bgColor,
    this.textColor,
    this.Icon,
    this.linkIcon,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Container(
      padding: EdgeInsets.only(
        top: responsive.heightFactor(0.05),
        left: responsive.widthFactor(0.05),
        right: responsive.widthFactor(0.05),
      ),
      width: double.infinity,
      height: responsive.heightFactor(0.14),
      color: bgColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child:
                Icon ??
                HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowLeft01,
                  color: AppColors.primaryColor,
                  size: 24.0,
                ),
          ),

          Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: responsive.heightFactor(0.025),
              fontWeight: FontWeight.bold,
            ),
          ),

          linkIcon ?? SizedBox(width: responsive.widthFactor(0.05)),
        ],
      ),
    );
  }
}
