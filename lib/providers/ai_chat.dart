import 'package:flutter/material.dart';
import 'package:healthai/services/api/http_request.dart';

class AiChatProvider extends ChangeNotifier {
  List<Map<String, String>> messages = []; 
  bool isTyping = false; 

  void clearChat() {
    messages.clear();
    notifyListeners();
  }

  Future<void> sendMessage(String message, {String? selectedModel}) async {
    messages.add({"role": "user", "text": message});
    isTyping = true;
    notifyListeners();

    late String apiMessage = messages[messages.length - 1]["text"]!;
    try {
      String response = await getLLMChat(
        apiMessage,
        selectedModel: selectedModel,
      );
      print("benim 5 mesaj: $message");

      isTyping = false;
      messages.add({"role": "bot", "text": response});
    } catch (e) {
      messages.add({
        "role": "bot",
        "text": "Bir hata oluştu, lütfen tekrar deneyin.",
      });
    }

    notifyListeners();
  }

  
}
