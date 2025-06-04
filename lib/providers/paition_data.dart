import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  int _currentStep = 0;
  String fullName = '';
  double height = 170.0;
  String heightUnit = 'cm';
  double weight = 70.0;
  String weightUnit = 'kg';
  int siblings = 0;
  DateTime birthDate = DateTime.now().subtract(const Duration(days: 365 * 20));
  String? bloodType;
  bool isRhPositive = true;
  int sleepRating = 3;

  var fullNameController;

  int get currentStep => _currentStep;

  void nextStep() {
    if (_currentStep < 6) {
      _currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void setFullName(String value) {
    fullName = value;
    notifyListeners();
  }

  void setHeight(double value) {
    height = value;
    notifyListeners();
  }

  void setHeightUnit(String unit) {
    heightUnit = unit;
    notifyListeners();
  }

  void setWeight(double value) {
    weight = value;
    notifyListeners();
  }

  void setWeightUnit(String unit) {
    weightUnit = unit;
    notifyListeners();
  }

  void setSiblings(int value) {
    siblings = value;
    notifyListeners();
  }

  void setBirthDate(DateTime date) {
    birthDate = date;
    notifyListeners();
  }

  void setBloodType(String? type) {
    bloodType = type;
    notifyListeners();
  }

  void setRhFactor(bool isPositive) {
    isRhPositive = isPositive;
    notifyListeners();
  }

  void setSleepRating(int rating) {
    sleepRating = rating;
    notifyListeners();
  }
}
