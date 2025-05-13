import 'package:flutter/material.dart';
import 'package:healthai/models/task.dart';
import 'package:healthai/providers/user_provider.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];


  fetchTasks(userId) async {
    ApiResponse response = await Api.send(EndPoints.taskList, params:userId);

    tasks = TaskModel.fromJsonList(response.data['result']);
    print("tasks: $tasks");
    notifyListeners();
  }
}
