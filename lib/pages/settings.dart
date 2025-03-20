import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/providers/user_provider.dart';
import 'package:healthai/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(title: "Profile Page", bgColor: AppColors.primaryColor),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.primaryColor),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      "assets/images/auth/profile.png",
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Tonald Drump",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Junior Full Stack Developer",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  _buildSection("CONTACT", [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/profile");
                      },
                      child: _buildListTile(Icons.person, "Profile"),
                    ),
                    _buildListTile(Icons.settings, "Settings"),
                    _buildListTile(Icons.help, "Help"),
                  ]),
                  _buildSection("Settings", [
                    _buildListTile(Icons.settings, "Q&A"),
                    _buildListTile(Icons.help, "About Us"),
                    _buildListTile(
                      Icons.logout,
                      "Logout",
                      onTap: () async {
                        await authProvider.logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ]),
                  SizedBox(height: 200,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String text, {
    Color? color,
    bool trailing = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primaryColor),
      title: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14),
        selectionColor: AppColors.textColorGray,
      ),
      onTap: onTap,
      trailing:
          trailing
              ? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
              : null,
    );
  }
}
