import 'package:flutter/material.dart';
import 'package:healthai/models/task.dart';
import 'package:healthai/services/api/api.dart';
import 'package:healthai/services/api/api_response.dart';
import 'package:healthai/services/api/endpoints.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];

  Future<bool> fetchTasks() async {
    ApiResponse response = await Api.send(EndPoints.taskList);

    tasks = TaskModel.fromJsonList(response.data['result']);
    notifyListeners();
    return true;
  }

  Future<void> completeTask(int taskId, bool isCompleted) async {
    try {
      ApiResponse response = await Api.send(
        EndPoints.taskComplete,params: [taskId, isCompleted],
      );

      if (response.success) {
        // Task'ı güncelle
        int index = tasks.indexWhere((task) => task.id == taskId);
        if (index != -1) {
          tasks[index].isCompleted = isCompleted;
          tasks[index].completedAt = isCompleted ? DateTime.now() : null;
          tasks[index].status = isCompleted ? 'completed' : 'pending';
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error completing task: $e');
    }
  }
}
