import 'package:flutter/material.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';
import 'package:healthai/services/api/http_request.dart';

class AiChatProvider extends ChangeNotifier {
  List<Map<String, String>> messages = []; 
  bool isTyping = false;
  List<String> aiModels = [];
  String? selectedModel;
  bool hasFetchedAppData = false;

  void clearChat() {
    messages.clear();
    notifyListeners();
  }

  void setAiModel(String model){
    selectedModel = model;
    notifyListeners();
  }

  Future<void> fetchAppData() async {
    if(hasFetchedAppData) return;
    hasFetchedAppData = true;

    ApiResponse apiResponse = await Api.send(EndPoints.appData);
    if(apiResponse.success){
      aiModels = List<String>.from(apiResponse.data['ai_models']);
      notifyListeners();
    }
  }

  Future<void> sendMessage(String message) async {
    messages.add({"role": "user", "text": message});
    isTyping = true;
    notifyListeners();

    String apiMessage = messages.last['text'] ?? '';
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
