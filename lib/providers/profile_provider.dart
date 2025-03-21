import 'package:flutter/material.dart';
import 'dart:io';

class ProfileProvider with ChangeNotifier {
  File? _image;
  String _firstName = "Tonald";
  String _lastName = "Drump";
  String _dob = "10 December 1997";
  String _position = "Junior Full Stack Developer";
  
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  File? get image => _image;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get dob => _dob;
  String get position => _position;
  
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get dobController => _dobController;

  ProfileProvider() {
    _firstNameController.text = _firstName;
    _lastNameController.text = _lastName;
    _dobController.text = _dob;
  }

  void updateImage(File newImage) {
    _image = newImage;
    notifyListeners();
  }

  void updateFirstName(String newValue) {
    _firstName = newValue;
    _firstNameController.text = newValue;
    notifyListeners();
  }

  void updateLastName(String newValue) {
    _lastName = newValue;
    _lastNameController.text = newValue;
    notifyListeners();
  }

  void updateDob(String newValue) {
    _dob = newValue;
    _dobController.text = newValue;
    notifyListeners();
  }

  void updatePosition(String newValue) {
    _position = newValue;
    notifyListeners();
  }
}
