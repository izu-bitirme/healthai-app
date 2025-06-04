import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(
          "About Health AI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Logo ve versiyon bilgisi
          Column(
            children: [
              Image.asset(
                "assets/images/app-icon.png",
                width: 100,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                "Health AI v5.7.8",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 40),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(context, "About Health AI"),
                _buildMenuItem(context, "Data Policy"),
                _buildMenuItem(context, "Cookies Policy"),
                _buildMenuItem(context, "Terms of Use"),
                _buildMenuItem(context, "Visit Our Website"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Buraya sayfa yönlendirmeleri eklenebilir
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("$title clicked")));
      },
    );
  }
}
