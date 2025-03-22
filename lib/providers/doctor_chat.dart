
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<Map<String, String>> _messages = [];
  bool _isTyping = false;

  List<Map<String, String>> get messages => _messages;
  bool get isTyping => _isTyping;

  void sendMessage(String text, {required String role}) {
    _messages.add({"role": role, "text": text});
    _isTyping = true;
    notifyListeners();

    // Simulate a response from the doctor
    Future.delayed(Duration(seconds: 1), () {
      _messages.add({"role": "doctor", "text": "Thank you for your message. I will get back to you shortly."});
      _isTyping = false;
      notifyListeners();
    });
  }
}