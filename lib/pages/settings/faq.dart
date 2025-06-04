import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class FAQPage extends StatelessWidget {
  FAQPage({super.key});

  final List<Map<String, String>> faqs = [
    {
      "question": "What is Health AI?",
      "answer":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    },
    {
      "question": "Is the Health AI App free?",
      "answer": "Yes, Health AI is free to use with optional premium features.",
    },
    {
      "question": "How can I use Health AI",
      "answer":
          "You can start using Health AI by signing up and exploring the features.",
    },
    {
      "question": "How can I log out from Health AI?",
      "answer": "Go to settings and tap the 'Log out' button.",
    },
    {
      "question": "How to close Health AI account?",
      "answer": "Contact support to permanently delete your account.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("FAQ"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
              faqs.map((faq) {
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AppColors.primaryColor),
                  ),
                  child: ExpansionTile(
                    shape: RoundedRectangleBorder(side: BorderSide.none),
                    title: Text(
                      faq["question"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowDown01,
                      color: AppColors.primaryColor,
                      size: 24.0,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(faq["answer"]!),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
