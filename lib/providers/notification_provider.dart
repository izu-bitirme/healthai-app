import 'package:flutter/material.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';

class NotificationProvider extends ChangeNotifier {
  List<String> notifications = [];

  fetchNotifications() async {
    ApiResponse response = await Api.send(EndPoints.notificationList);
    if (response.success) {
      for (dynamic item in response.data['notifications']) {
        notifications.add(item['message']);
      }
      notifyListeners();
    }
  }
}
