import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthai/models/chat.dart';

class MessageProvider extends ChangeNotifier {
  List<ChatMessage> messages = [];

  onMessage(data) {
    var jsonData = jsonDecode(data);
    print("messages: ${jsonData}");
    if (jsonData['type'] != 'chat_message') return;
    messages.add(ChatMessage.fromJson(jsonData));
    notifyListeners();
  }

  clearChat() {
    messages.clear();
    notifyListeners();
  }
  
}
