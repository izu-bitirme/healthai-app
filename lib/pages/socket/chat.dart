import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthai/constants/app_colors.dart';
import 'package:healthai/models/chat.dart';
import 'package:healthai/providers/message_provider.dart';
import 'package:healthai/providers/socket_chat.dart';
import 'package:healthai/services/chat.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  final int doctorId;
  final String doctorName;
  final String doctorImage;
  final String roomName;

  const ChatPage({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    required this.doctorImage,
    required this.roomName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final textController = TextEditingController();
    final messageProvider = Provider.of<MessageProvider>(context);

    void scrollToBottom() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }

    Future<void> sendMessage() async {
      if (textController.text.trim().isEmpty) return;

      final message = textController.text;
      textController.clear();

      try {
        ChatChannel.sendTextMessage(message: message, receiverId: doctorId);
        scrollToBottom();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to send message: $e')));
        textController.text = message;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(context),
              if (messageProvider.messages.isEmpty)
                _buildEmptyState()
              else
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: messageProvider.messages.length,
                    itemBuilder: (context, index) {
                      if (index == messageProvider.messages.length) {
                        return _buildTypingIndicator();
                      }
                      return _buildMessageBubble(
                        messageProvider.messages[index],
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),
              _buildInputArea(textController, sendMessage),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionStatus(ChatProvider chatProvider) {
    if (chatProvider.error != null) {
      return GestureDetector(
        onTap: chatProvider.reconnect,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Colors.red,
          child: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  chatProvider.error!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Text(
                'Tap to reconnect',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment:
          message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color:
              message.isSender ? AppColors.cardPrimaryColor : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(message.isSender ? 12 : 0),
            bottomRight: Radius.circular(message.isSender ? 0 : 12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: TextStyle(
                color: message.isSender ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: 50,
            height: 20,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [Colors.grey],
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(
    TextEditingController controller,
    VoidCallback onSend,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Type your message...",
              filled: true,
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (_) => onSend(),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onSend,
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor.withOpacity(0.8),
            radius: 24,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 0, right: 10, bottom: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(doctorImage),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  doctorName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedBubbleChat,
            color: Colors.black54,
            size: 48.0,
          ),
          const SizedBox(height: 10),
          Text(
            "Start a conversation",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          _capabilityBox(
            "Ask about your health concerns.",
            "(Dr. ${doctorName.split(' ')[1]} is here to help!)",
          ),
          _capabilityBox(
            "Discuss your symptoms.",
            "(Get advice on what to do next)",
          ),
          _capabilityBox(
            "Get medical advice.",
            "(Professional guidance at your fingertips)",
          ),
          const SizedBox(height: 20),
          Text(
            "Dr. ${doctorName.split(' ')[1]} is ready to assist you.",
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }

  Widget _capabilityBox(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
