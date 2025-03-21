import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/providers/doctor_chat.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  left: 0,
                  right: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/images/doctor.png"), // Doktor resmi
                            radius: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Dr. Drake Boeson",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 48), 
                  ],
                ),
              ),

              if (Provider.of<ChatProvider>(context)
                  .messages
                  .isEmpty)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(icon: HugeIcons.strokeRoundedBubbleChat, color: Colors.black54, size: 48.0,),
                      SizedBox(height: 10),
                      Text(
                        "Start a conversation",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),
                      _capabilityBox(
                        "Ask about your health concerns.",
                        "(Dr. Drake is here to help!)",
                      ),
                      _capabilityBox(
                        "Discuss your symptoms.",
                        "(Get advice on what to do next)",
                      ),
                      _capabilityBox(
                        "Get medical advice.",
                        "(Professional guidance at your fingertips)",
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Dr. Drake is ready to assist you.",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                ),

              if (Provider.of<ChatProvider>(context)
                  .messages
                  .isNotEmpty) 
                Expanded(
                  child: Consumer<ChatProvider>(
                    builder: (context, chatProvider, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToBottom(); 
                      });

                      return ListView.builder(
                        controller:
                            _scrollController, 
                        itemCount:
                            chatProvider.messages.length +
                            (chatProvider.isTyping ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == chatProvider.messages.length &&
                              chatProvider.isTyping) {
                            return Padding(padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: ListTile(
                              key: ValueKey("typing"),
                              title: SizedBox(
                                height: 15,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [AppColors.primaryColor],
                                  strokeWidth: 3,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                            );
                          }

                          var message = chatProvider.messages[index];
                          return Align(
                            key: ValueKey(index),
                            alignment:
                                message['role'] == "user"
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color:
                                    message['role'] == "user"
                                        ? AppColors.cardPrimaryColor
                                        : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message['text']!,
                                style: TextStyle(color:  message['role'] == "user" ? Colors.white : Colors.black),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
             
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      if (_controller.text.isNotEmpty) {
                        context.read<ChatProvider>().sendMessage(
                          _controller.text,
                          role: "user",
                        );
                        _controller.clear();
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.8),
                      radius: 24,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _capabilityBox(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
