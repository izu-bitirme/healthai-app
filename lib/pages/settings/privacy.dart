import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => {if (Navigator.canPop(context)) Navigator.pop(context)},
        ),
        title: const Text("Privacy Policy"),
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
            RichText(
              text: const TextSpan(
                text: "At ",
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: "Health AI",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ", we respect and protect the privacy of our users. This Privacy Policy outlines the types of personal information we collect, how we use it, and how we protect your information.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Information We Collect",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoItem(
              title: "Device Information",
              description:
                  "We may collect information about the type of device you use, its operating system, and other technical details to help us improve our app.",
            ),
            _buildInfoItem(
              title: "Usage Information",
              description:
                  "We may collect information about how you use our app, such as which features you use and how often you use them.",
            ),
            _buildInfoItem(
              title: "Personal Information",
              description:
                  "We may collect personal information, such as your name, email address, or phone number, if you choose to provide it to us.",
            ),
            const SizedBox(height: 20),
            const Text(
              "How We Use Your Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoItem(
              title: "To provide and improve our app",
              description:
                  "We use your information to provide and improve our app.",
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
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
    );
  }
}
