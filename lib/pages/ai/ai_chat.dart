import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/providers/ai_chat.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class ChatAiPage extends StatefulWidget {
  const ChatAiPage({super.key});

  @override
  _ChatAiPageState createState() => _ChatAiPageState();
}

class _ChatAiPageState extends State<ChatAiPage> {
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
    final selectedModel = Provider.of<AiChatProvider>(context).selectedModel;
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
                          Image.asset(selectedModel==null ? "assets/images/llama.png" :"assets/images/$selectedModel.png", width: 35, height: 35),
                          SizedBox(width: 8),
                          Text(
                            selectedModel==null ? "llamma 3.2" :selectedModel.toString() ,
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

              if (Provider.of<AiChatProvider>(context)
                  .messages
                  .isEmpty)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_awesome, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "Capabilities",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),
                      _capabilityBox(
                        "Answer all your questions.",
                        "(Just ask me anything you like!)",
                      ),
                      _capabilityBox(
                        "Generate all the text you want.",
                        "(essays, articles, reports, stories, & more)",
                      ),
                      _capabilityBox(
                        "Conversational AI.",
                        "(I can talk to you like a natural human)",
                      ),
                      SizedBox(height: 20),
                      Text(
                        "These are just a few examples of what I can do.",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                ),

              if (Provider.of<AiChatProvider>(context)
                  .messages
                  .isNotEmpty) 
                Expanded(
                  child: Consumer<AiChatProvider>(
                    builder: (context, chatProvider, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToBottom(); //
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
                                        ? AppColors.primaryColorLight
                                        : AppColors.cardGreyColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message['text']!,
                                style: TextStyle(color: AppColors.textColor),
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
                        hintText: "Ask me anything...",
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
                        context.read<AiChatProvider>().sendMessage(
                          _controller.text,
                        );
                        _controller.clear();
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
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
