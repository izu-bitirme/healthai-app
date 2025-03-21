import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController otpController = TextEditingController();
  int endTime =
      DateTime.now().millisecondsSinceEpoch + 60000; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Align(alignment: Alignment.centerLeft, child: BackButton()),
            const SizedBox(height: 20),
            const Text(
              "OTP code verification 🔒",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "We have sent an OTP code to your email and ********ley@yourdomain.com. Enter the OTP code below to verify.",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 50),
            PinCodeTextField(
              length: 4,
              obscureText: false,
              cursorColor: AppColors.primaryColorLight,

              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 60,
                fieldWidth: 60,
                activeFillColor: Colors.white,
                inactiveFillColor: Color(0xFFF4F4F4),
                selectedFillColor: Colors.white,
                inactiveColor: Color(0xFFEEEEEE),
                activeColor: AppColors.cardPrimaryColor,
                selectedColor: AppColors.primaryColor,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              controller: otpController,
              onChanged: (value) {},
              appContext: context,
            ),
            const SizedBox(height: 20),
            CountdownTimer(
              endTime: endTime,
              textStyle: const TextStyle(
                
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
              onEnd: () {
                setState(() {});
              },
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                "You can resend code in 55 s",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/new-password");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
