import 'package:flutter/material.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';


class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse response = await Api.send(EndPoints.login, body: {
      'email': email,
      'password': password,
    });
    return response;
  }
}