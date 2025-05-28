import 'package:flutter/material.dart';
import 'package:healthai/models/auth/profile.dart';
import 'package:healthai/models/auth/user.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';
import 'package:healthai/services/app_status.dart';
import 'package:healthai/services/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  Future<ApiResponse> login(String email, String password) async {
    ApiResponse response = await Api.send(
      EndPoints.login,
      body: {'username': email, 'password': password},
    );
    if (response.success) {
      await TokenService.saveTokens(response.data);
      AppStatus.setLogin(isLogin: true);
      notifyListeners();
    }
    return response;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String username,
  }) async {
    ApiResponse response = await Api.send(
      EndPoints.registerProfile,
      body: {'password': password, 'email': email},
    );

    return response.success;
  }

  Future<bool> logout() async {
    await TokenService.removeTokens();
    AppStatus.setLogin(isLogin: false);
    notifyListeners();
    return true;
  }

  refreshToken() async {
    ApiResponse response = await Api.send(
      EndPoints.refreshToken,
      body: {'refresh': await TokenService.getRefreshToken()},
    );

    try {
      await TokenService.saveTokens(response.data);
      AppStatus.setLogin(isLogin: true);
    } catch (e) {
      AppStatus.setLogin(isLogin: false);

      print(e);
    }
  }
}
