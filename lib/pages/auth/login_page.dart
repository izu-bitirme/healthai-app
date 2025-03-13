import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/constants/app_respons.dart';
import 'package:healthai/widgets/auth/modal.dart';
import 'package:hugeicons/hugeicons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  void _handleLogin(BuildContext context) {
    ModalDialog.show(
      context,
      title: 'Giriş Yapılıyor',
      message: 'Lütfen Bekleyiniz',
      imagePath: 'assets/images/auth/success.png',
      autoCloseSeconds: 2,
    );

    Future.delayed(Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.widthFactor(0.08),
            ), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: responsive.heightFactor(0.02)),

                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    color: AppColors.iconColorGray,
                    size: responsive.widthFactor(0.08),
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.03)),

                Text(
                  "Welcome back 👋",
                  style: TextStyle(
                    fontSize: responsive.fontSize(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.01)),

                Text(
                  "Please enter your email & password to log in.",
                  style: TextStyle(
                    fontSize: responsive.fontSize(14),
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.03)),

                const Text("Email address"),
                SizedBox(height: responsive.heightFactor(0.005)),

                SizedBox(
                  height: responsive.heightFactor(0.07),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          responsive.widthFactor(0.1),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                        size: responsive.widthFactor(0.06),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.025)),

                const Text("Password"),
                SizedBox(height: responsive.heightFactor(0.005)),

                SizedBox(
                  height: responsive.heightFactor(0.07), 
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          responsive.widthFactor(0.1),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: responsive.widthFactor(0.06),
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: Colors.grey,
                        size: responsive.widthFactor(0.06),
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      value: true,
                      activeColor: AppColors.primaryColor,
                      checkColor: Colors.white,
                      side: BorderSide(color: AppColors.primaryColor),
                      onChanged: (bool? value) {},
                    ),
                    const Text("Remember me"),
                  ],
                ),
                SizedBox(height: responsive.heightFactor(0.01)),

                Divider(color: AppColors.dividerColor, thickness: 0.8),
                SizedBox(height: responsive.heightFactor(0.01)),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/reset-password');
                  },
                  child: Center(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.01)),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Center(
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.03)),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.dividerColor,
                        thickness: 0.8,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.widthFactor(0.02),
                      ),
                      child: Text(
                        "or continue with",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.dividerColor,
                        thickness: 0.8,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.heightFactor(0.025)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: responsive.heightFactor(
                        0.06,
                      ), 
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/auth/google.png',
                          height: responsive.heightFactor(0.025),
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              responsive.widthFactor(0.2),
                            ),
                          ),
                          side: BorderSide(color: Colors.grey.shade200),
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.widthFactor(0.09),
                            vertical: responsive.heightFactor(0.015),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: responsive.widthFactor(0.05)),

                    SizedBox(
                      height: responsive.heightFactor(
                        0.06,
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/auth/apple.png',
                          height: responsive.heightFactor(0.025),
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              responsive.widthFactor(0.2),
                            ),
                          ),
                          side: BorderSide(color: Colors.grey.shade200),
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.widthFactor(0.09),
                            vertical: responsive.heightFactor(0.015),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Divider(color: AppColors.dividerColor, thickness: 0.5),
                SizedBox(height: responsive.heightFactor(0.02)),

                SizedBox(
                  width: double.infinity,
                  height: responsive.heightFactor(0.07),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          responsive.widthFactor(0.2),
                        ),
                      ),
                    ),
                    onPressed: () => _handleLogin(context),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: responsive.fontSize(18),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.02)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
