import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool rememberMe = true;
  bool biometricID = false;
  bool faceID = false;
  bool smsAuthenticator = false;
  bool googleAuthenticator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "App Settings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSwitchTile("Remember me", rememberMe, (val) {
            setState(() => rememberMe = val);
          }),
          _buildSwitchTile("Biometric ID", biometricID, (val) {
            setState(() => biometricID = val);
          }),
          _buildSwitchTile("Face ID", faceID, (val) {
            setState(() => faceID = val);
          }),
          _buildSwitchTile("SMS Authenticator", smsAuthenticator, (val) {
            setState(() => smsAuthenticator = val);
          }),
          _buildSwitchTile("Google Authenticator", googleAuthenticator, (val) {
            setState(() => googleAuthenticator = val);
          }),
          ListTile(
            title: const Text("Device Management"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {}, // Buraya yönlendirme ekleyebilirsin.
          ),
          const SizedBox(height: 20),
          _buildChangePasswordButton(),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primaryColor,
    );
  }

  Widget _buildChangePasswordButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/reset-password');
          }, // Şifre değiştirme işlemi buraya eklenebilir.
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedResetPassword,
                color: Colors.white,
                size: 24.0,
              ),
              const SizedBox(width: 10),

              Text("Change Password"),
            ],
          ),
        ),
      ),
    );
  }
}
