import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ModalDialog extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath;
  final int autoCloseSeconds;

  const ModalDialog({
    super.key,
    required this.title,
    required this.message,
    required this.imagePath,
    this.autoCloseSeconds = 2,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required String imagePath,
    int autoCloseSeconds = 2,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => ModalDialog(
            title: title,
            message: message,
            imagePath: imagePath,
            autoCloseSeconds: autoCloseSeconds,
          ),
    );

    Future.delayed(Duration(seconds: autoCloseSeconds), () {
      if (context.mounted) {
        if (Navigator.canPop(context)) Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 180),
            SizedBox(height: 20),

            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 50,
              child: LoadingIndicator(
                indicatorType: Indicator.ballRotateChase,
                colors: [AppColors.primaryColor],
                strokeWidth: 3,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
