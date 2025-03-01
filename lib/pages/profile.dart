import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/widgets/custom_app_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(title: "deneme",iconButton:IconButton(onPressed: (){}, icon: HugeIcon(icon: HugeIcons.strokeRoundedAddCircleHalfDot,color: AppColors.backgroundColor,)),bgColor:AppColors.primaryColor),
            Stack(
              children: [
               
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      _buildSection("CONTACT", [
                        _buildListTile(Icons.person, "Profile"),
                        _buildListTile(Icons.settings, "Settings"),
                        _buildListTile(Icons.help, "Help"),
                        _buildListTile(Icons.logout, "Logout"),
                      ]),
                      _buildSection("ACCOUNT", [
                        _buildListTile(Icons.person, "Profile"),
                        _buildListTile(Icons.settings, "Settings"),
                        _buildListTile(Icons.help, "Help"),
                        _buildListTile(Icons.logout, "Logout"),
                      ]),
                      _buildSection("OTHERS", [
                        _buildListTile(Icons.person, "Profile"),
                        _buildListTile(Icons.settings, "Settings"),
                        _buildListTile(Icons.help, "Help"),
                        _buildListTile(Icons.logout, "Logout"),
                      ]),
                    ],
                  ),
                ),
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
              ],
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
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.deepPurple),
      title: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14),
        selectionColor: AppColors.textColorGray,
      ),
      trailing:
          trailing
              ? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
              : null,
    );
  }
}
