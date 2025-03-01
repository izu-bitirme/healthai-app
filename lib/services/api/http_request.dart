
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';




Future<String> getLLMChat(String message, {String? selectedModel}) async {
  String model = selectedModel ?? "";
  Map<String, dynamic> endpoint = model != null
      ? {"url": "chat-bot/chat-response/?message=${message}&model=${model}", "method": "GET"}
      : {"url": "chat-bot/chat-response/?message=${message}", "method": "GET"};
  ApiResponse response = await Api.send(endpoint);

  if (response.success) {
    return response.data['message'];
  } else {
    return "Bir hata oluştu, lütfen tekrar deneyin.";
  }
}
