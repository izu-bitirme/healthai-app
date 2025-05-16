import 'package:flutter/material.dart';
import 'package:healthai/models/doctor.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> doctors = [];
  
  // Doktorları çekmek için API çağrısı
  Future<void> fechDoctors() async {
    ApiResponse response = await Api.send(EndPoints.doctorList);
      print("Veri tipi: ${response.data}");
      if (response.success) {
      print("Doktorlar çekildi: ${response.data}");
      doctors = DoctorModel.fromJsonList(response.data['doctors'] as List<dynamic>);
      print("Doktorlar çekildi: ${doctors.length}");
      notifyListeners();
    } else {
      print("Doktorlar çekilemedi: ${response.message}");
    }
  }
}
