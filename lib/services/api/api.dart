import 'dart:convert';
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

  static Future<ApiResponse> send(
    Map endpoint, {
    List<dynamic> params = const [],
    Map<String, dynamic> body = const {},
  }) async {
    String method = endpoint.containsKey('method') ? endpoint['method'] : "GET";
    String url = getUrl(endpoint, params);
    bool requiresAuth = endpoint['login_required'] ?? false;

    Map<String, String> headers =
        requiresAuth
            ? await Api.getHeaders()
            : {"Content-Type": "application/json"};

    Future<http.Response> performRequest() async {
      final uri = Uri.parse(url);
      final encodedBody = jsonEncode(body);

      switch (method) {
        case "GET":
          return await http.get(uri, headers: headers);
        case "DELETE":
          return await http.delete(uri, headers: headers, body: encodedBody);
        default:
          return await http.post(uri, headers: headers, body: encodedBody);
      }
    }

    http.Response response;
    print("Headers------: $headers");

    try {
      response = await performRequest();
      if (response.statusCode == 401) {
        if (url.toString().contains('refresh')) {
          await TokenService.removeTokens();
          return ApiResponse(
            data: {},
            success: false,
            title: 'Session expired',
            message: 'Please login again.',
          );
        }
        final refreshResponse = await send(
          EndPoints.refreshToken,
          body: {'refresh': await TokenService.getRefreshToken()},
        );

        if (refreshResponse.success) {
          await TokenService.saveTokens(refreshResponse.data);
          headers = await Api.getHeaders();
          response = await performRequest();
        } else {}
      }

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse(
        data: {},
        success: false,
        title: 'Error',
        message: 'Please check your internet connection and try again later.',
      );
    }
  }
}
