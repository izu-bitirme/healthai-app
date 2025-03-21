import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/constants/app_respons.dart';
import 'package:healthai/providers/user_provider.dart';
import 'package:healthai/widgets/auth/modal.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  void _handleSignUp(BuildContext context) async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);

    bool isSuccess = await userProvider.register(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
    );

    if (isSuccess) {
      ModalDialog.show(
        context,
        title: 'Kayıt Yapılıyor',
        message: 'Lütfen Bekleyiniz',
        imagePath: 'assets/images/auth/success.png',
        autoCloseSeconds: 2,
      );

      Future.delayed(Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pushNamed(context, '/login');
        }
      });
    }
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
                SizedBox(height: responsive.heightFactor(0.02)),

                Text(
                  "Create an Account 🎉",
                  style: TextStyle(
                    fontSize: responsive.fontSize(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.01)),

                Text(
                  "Fill in the details below to sign up.",
                  style: TextStyle(
                    fontSize: responsive.fontSize(14),
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.03)),

                const Text("Full Name"),
                SizedBox(height: responsive.heightFactor(0.005)),
                _buildTextField(
                  "Full Name",
                  Icons.person,
                  responsive,
                  controller: usernameController,
                ),
                SizedBox(height: responsive.heightFactor(0.02)),

                const Text("Email Address"),
                SizedBox(height: responsive.heightFactor(0.005)),
                _buildTextField(
                  "Email",
                  Icons.email,
                  responsive,
                  controller: emailController,
                ),
                SizedBox(height: responsive.heightFactor(0.02)),

                const Text("Password"),
                SizedBox(height: responsive.heightFactor(0.005)),
                _buildTextField(
                  "Password",
                  Icons.lock,
                  responsive,
                  isPassword: true,
                  controller: passwordController,
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
                    const Text("I agree to the Terms & Conditions"),
                  ],
                ),
                SizedBox(height: responsive.heightFactor(0.01)),
                Divider(color: AppColors.dividerColor, thickness: 0.8),
                SizedBox(height: responsive.heightFactor(0.01)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: responsive.heightFactor(0.06),
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
                      height: responsive.heightFactor(0.06),
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
                    onPressed: () => _handleSignUp(context),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: responsive.fontSize(18),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.01)),

                Center(
                  child: InkWell(
                    onTap: () => _handleSignUp(context),
                    child: Text(
                      "Already have an account? Log in",
                      style: TextStyle(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.heightFactor(0.03)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    IconData icon,
    Responsive responsive, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return SizedBox(
      height: responsive.heightFactor(0.07),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive.widthFactor(0.1)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
            size: responsive.widthFactor(0.06),
          ),
          suffixIcon:
              isPassword
                  ? Icon(
                    Icons.visibility,
                    color: Colors.grey,
                    size: responsive.widthFactor(0.06),
                  )
                  : null,
        ),
      ),
    );
  }
}
