import 'dart:convert';
import 'package:healthai/providers/user_provider.dart';
import 'package:healthai/services/api/http_request.dart';
import 'package:healthai/services/token.dart';
import 'endpoints.dart';
import 'package:http/http.dart' as http;
import 'api_response.dart';

class Api {
  static const String host = "http://127.0.0.1:8000";
  static const String apiHost = "$host/api/";

  static String getUrl(Map endpoint, List<dynamic> params) {
    String url = endpoint['url'];
    for (var param in params) {
      url = url.replaceFirst(EndPoints.paramIdentifier, param.toString());
    }
    return apiHost + url;
  }

  static Future<Map<String, String>> getHeaders() async {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await TokenService.getAccessToken()}",
    };
  }

  static send(
    Map endpoint, {
    List<dynamic> params = const [],
    Map<String, dynamic> body = const {},
  }) async {
    String method = endpoint.containsKey('method') ? endpoint['method'] : "GET";
    String url = getUrl(endpoint, params);
    Map<String, String> headers =
        endpoint.containsKey('login_required')
            ? endpoint['login_required']
                ? await Api.getHeaders()
                : {"Content-Type": "application/json"}
            : {"Content-Type": "application/json"};

    late http.Response response;

    try {
      if (method == "GET") {
        response = await http.get(Uri.parse(url), headers: headers);
      } else if (method == "DELETE") {
        response = await http.delete(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );
      } else {
        response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );
      }
      if (response.statusCode == 401) {
        final authProvider = AuthProvider();
        ApiResponse refreshResponse = await authProvider.refreshToken();

        if (refreshResponse.success) {
          headers = await getHeaders();
          if (method == "GET") {
            response = await http.get(Uri.parse(url), headers: headers);
          } else if (method == "DELETE") {
            response = await http.delete(
              Uri.parse(url),
              headers: headers,
              body: jsonEncode(body),
            );
          } else {
            response = await http.post(
              Uri.parse(url),
              headers: headers,
              body: jsonEncode(body),
            );
          }
        } else {
          return "";
        }
      }
    } catch (e) {
      return ApiResponse(
        data: {},
        success: false,
        title: 'Error',
        message: 'Please  try your internet connection and try again later',
      );
    }

    return ApiResponse.fromResponse(response);
  }
}
