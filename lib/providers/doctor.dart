import 'package:flutter/material.dart';
import 'package:healthai/models/doctor.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> doctors = [];
  
  fechDoctors() async {
    ApiResponse response = await Api.send(EndPoints.doctorList);
    doctors = DoctorModel.fromJsonList(response.data['result']);
    notifyListeners();
  }
}
