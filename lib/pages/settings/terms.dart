import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TermsConditionsPage(),
  ));
}

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Terms & Conditions"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Health AI!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "These terms and conditions outline the rules and regulations for the use of our app.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Acceptance of Terms",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoItem(
              title: "Agreement",
              description:
                  "By accessing and using this app, you accept and agree to be bound by these Terms and Conditions.",
            ),
            _buildInfoItem(
              title: "Changes",
              description:
                  "We reserve the right to modify these terms at any time, so please review them regularly.",
            ),
            const SizedBox(height: 20),
            const Text(
              "User Responsibilities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoItem(
              title: "Proper Use",
              description:
                  "You agree not to misuse the app or engage in any illegal activities while using it.",
            ),
            _buildInfoItem(
              title: "Account Security",
              description:
                  "You are responsible for maintaining the security of your account and password.",
            ),
            const SizedBox(height: 20),
            const Text(
              "Limitation of Liability",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoItem(
              title: "No Warranties",
              description:
                  "The app is provided 'as is' without any warranties or guarantees.",
            ),
            _buildInfoItem(
              title: "Liability Limit",
              description:
                  "We are not responsible for any damages or losses resulting from the use of this app.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({required String title, required String description}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Text("•", style: TextStyle(fontSize: 20)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
    );
  }
}
