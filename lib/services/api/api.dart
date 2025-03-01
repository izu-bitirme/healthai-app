import 'dart:convert';
import 'package:healthai/services/api/endpoints.dart';
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

  static Map<String, String> getHeaders() {
    return {
      "Content-Type": "application/json",
    };
  }

  static send(
    Map endpoint, {
    List<dynamic> params = const [],
    Map<String, dynamic> body = const {},
  }) async {
    String method = endpoint.containsKey('method') ? endpoint['method'] : "GET";
    String url = getUrl(endpoint, params);
    Map<String, String> headers = getHeaders();

    late http.Response response;

    try {
      Uri uri = Uri.parse(url);
      if (method == "GET" && body.isNotEmpty) {
        uri = uri.replace(queryParameters: body.map((key, value) => MapEntry(key, value.toString())));
      }

      if (method == "GET") {
        response = await http.get(uri, headers: headers);
      } else if (method == "DELETE") {
        response = await http.delete(uri, headers: headers, body: jsonEncode(body));
      } else if (method == "PUT") {
        response = await http.put(uri, headers: headers, body: jsonEncode(body));
      } else if (method == "PATCH") {
        response = await http.patch(uri, headers: headers, body: jsonEncode(body));
      } else {
        response = await http.post(uri, headers: headers, body: jsonEncode(body));
      }

      if (response.statusCode != 200) {
        return ApiResponse(
          data: {},
          success: false,
          title: 'Error',
          message: 'Server error: ${response.statusCode} - ${response.body}',
        );
      }

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse(
        data: {},
        success: false,
        title: 'Error',
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }
}
