import 'package:flutter/material.dart';

class KvkkProvider with ChangeNotifier {
  bool _isAccepted = false;

  bool get isAccepted => _isAccepted;

  void acceptKvkk() {
    _isAccepted = true;
    notifyListeners();
  }

  void declineKvkk() {
    _isAccepted = false;
    notifyListeners();
  }
}
