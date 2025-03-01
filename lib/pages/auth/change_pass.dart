import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _isObscured1 = true;
  bool _isObscured2 = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(alignment: Alignment.topLeft, child: BackButton()),
              Text(
                "Create New Password 🔒",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Create your new password. If you forget it, then you have to do forgot password.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 24),
              _buildPasswordField("New Password", _passwordController, _isObscured1, () {
                setState(() {
                  _isObscured1 = !_isObscured1;
                });
              }),
              SizedBox(height: 16),
              _buildPasswordField("Confirm New Password", _confirmPasswordController, _isObscured2, () {
                setState(() {
                  _isObscured2 = !_isObscured2;
                });
              }),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5A4FCF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool isObscured, VoidCallback toggleVisibility) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscured,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            suffixIcon: IconButton(
              icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility, color: Colors.blueAccent),
              onPressed: toggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: AppColors.grayColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: AppColors.grayColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: AppColors.cardPrimaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
