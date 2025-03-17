import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider with ChangeNotifier {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  File? get image => _image;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }
}