import 'package:flutter/material.dart';
import 'package:healthai/models/patient.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';

class PatientProvider extends ChangeNotifier {
  Patient? patient;

  Future<Patient?> fetchPatient() async {
    ApiResponse response = await Api.send(EndPoints.patientDetail);
    if (response.success) {
      patient = Patient.fromJson(response.data);
      notifyListeners();
    }
    notifyListeners();
    return patient;
  }

  submitPatintData({double height_before = 0, double weight = 0}) async {
    ApiResponse response = await Api.send(
      EndPoints.submitPatientData,
      body: {'height_before': height_before, 'weight': weight},
    );

    return response;
  }
}
