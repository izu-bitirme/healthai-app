import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/constants/app_respons.dart';
import 'package:healthai/providers/ai_chat.dart';
import 'package:healthai/widgets/custom_app_bar.dart';
import 'package:healthai/widgets/custom_modal.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class WelcomeChat extends StatelessWidget {
  const WelcomeChat({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    var chatProvider = Provider.of<AiChatProvider>(context);

    chatProvider.fetchAppData();

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          chatProvider.aiModels.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  CustomAppBar(
                    title: "Health AI",
                    bgColor: Colors.white,
                    Icon: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeft01,
                        color: AppColors.textColor,
                        size: 28.0,
                      ),
                    ),
                    textColor: AppColors.textColor,
                    linkIcon: InkWell(
                      onTap : (){
                        CustomModal.show(
                        context: context,
                        title: 'Select Your LLM Model ✨',
                        children: [
                          for (String chatModel in chatProvider.aiModels)
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  chatProvider.setAiModel(chatModel);
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/chat-ai');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 30,
                                  ),
                                ),
                                child: Text(
                                  chatModel,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                        ],
                        buttonText: 'Tamam',
                        onButtonTap: () {
                          Navigator.pop(context);
                        },
                        isDismissible: false,
                      );
                      },
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedChatGpt,
                        color: AppColors.textColor,
                        size: 24.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.auto_awesome,
                    size: 100,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Health AI 👋',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Start chatting with ChattyAI now.\nYou can ask me anything.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/chat-ai');
                        },
                        child: Text(
                          'Start Chat',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.heightFactor(0.12)),
                ],
              ),
    );
  }
}
