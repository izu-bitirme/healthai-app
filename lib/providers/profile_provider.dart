
import 'package:flutter/material.dart';
import 'package:healthai/models/auth/profile.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? profile;
  String? userId;  
  Future<void> fetchProfile() async {
    try {
      ApiResponse response = await Api.send(EndPoints.profile);
      profile = ProfileModel.fromJson(response.data['result']);
      notifyListeners();
      print(profile);
    } catch (e) {
      print("Error fetching profile: $e");
      rethrow;
    }
  }
}

