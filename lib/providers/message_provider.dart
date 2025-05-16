import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthai/models/chat.dart';

class MessageProvider extends ChangeNotifier {
  List<ChatMessage> messages = [];

  onMessage(data) {
    var jsonData = jsonDecode(data);
    if (jsonData['type'] != 'text') return;
    messages.add(ChatMessage.fromJson(jsonData));
    notifyListeners();
  }
}
