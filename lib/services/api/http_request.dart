import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';

Future<String> getLLMChat(String message, {String? selectedModel}) async {
  ApiResponse response = await Api.send(
    EndPoints.chatBot,
    params:  [message, selectedModel],
  );

  if (response.success) {
    return response.data['message'];
  } else {
    return "Bir hata oluştu, lütfen tekrar deneyin.";
  }
}

Future<String> login() async {
  ApiResponse response = await Api.send(
    EndPoints.login,
    body: {'username': 'a', 'password': '1'},
  );

  return response.data['access'];
}
