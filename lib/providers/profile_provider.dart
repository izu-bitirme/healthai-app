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
      print("Veri tipi: ${response.data.runtimeType}");
      print("Veri: ${response.data}");
      profile = ProfileModel.fromJson(response.data);
      notifyListeners();
      print("Profile loaded: ${profile?.email}");
    } catch (e) {
      print("Error fetching profile: $e");
      rethrow;
    }
  }
}
