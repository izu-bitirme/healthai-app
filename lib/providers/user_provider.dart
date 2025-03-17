

import 'package:flutter/material.dart';
import 'package:healthai/models/auth/profile.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';
import 'package:healthai/services/token.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  ProfileModel? profile;

  String? userId;

  bool get isLoading => _isLoggedIn;

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse response = await Api.send(EndPoints.login, body: {
      'username': email,
      'password': password,
    });

    if (response.success) {
      await TokenService.saveTokens(response.data);
      _isLoggedIn = true;
      if (profile?.email == email) {
        userId = profile?.id as String?;
      }
    }
    return response;
  }

  refreshToken() async {
    ApiResponse response = await Api.send(EndPoints.refreshToken, body: {
      'refresh': await TokenService.getRefreshToken(),
    });

    try {
      await TokenService.saveTokens(response.data);
      _isLoggedIn = true;
    } catch (e) {
      _isLoggedIn = false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String username,
  }) async {
    ApiResponse response = await Api.send(EndPoints.registerProfile, body: {
      'full_name': username,
      'password': password,
      'email': email
    });

    return response.success;
  }

  Future<bool> logout() async {
    await TokenService.removeTokens();
    return true;
  }
}