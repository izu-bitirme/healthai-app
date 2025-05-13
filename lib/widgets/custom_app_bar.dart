import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/constants/app_respons.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color? textColor;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.bgColor,
    this.textColor,
    this.leadingIcon,
    this.trailingIcon,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leadingIcon != null
              ? _iconContainer(child: leadingIcon!)
              : const SizedBox(width: 40), // boşluk bırakmak için

          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: responsive.heightFactor(0.025),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          trailingIcon != null
              ? _iconContainer(child: trailingIcon!)
              : const SizedBox(width: 40), // boşluk bırakmak için
        ],
      ),
    );
  }

  Widget _iconContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
