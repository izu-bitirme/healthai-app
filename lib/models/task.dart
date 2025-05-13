
class TaskModel {
  late int id;
  late String title;
  late String description;
  late DateTime createdAt;
  late DateTime dueDate;
  late String status;
  late String priority;
  late bool isCompleted;
  DateTime? completedAt;
  late int patient;
  int? assignedTo;

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = DateTime.parse(json['created_at']);
    dueDate = DateTime.parse(json['due_date']) ;
    status = json['status'];
    priority = json['priority'];
    isCompleted = json['is_completed'];
    completedAt = json['completed_at'] != null ? DateTime.tryParse(json['completed_at']) : null;
    patient = json['patient'];
    assignedTo = json['assigned_to'];
  }

  static List<TaskModel> fromJsonList(dynamic list) {
    List<TaskModel> result = [];
    for (var item in list) {
      result.add(TaskModel.fromJson(item));
    }
    return result;
  }
}
