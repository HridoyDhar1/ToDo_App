
import 'package:todo/data/model/taskstatus_model.dart';

class TaskStatusCountModel {
  String? status;
  List<TaskStatusModel>? taskStatusCountList;

  TaskStatusCountModel({this.status, this.taskStatusCountList});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountList = <TaskStatusModel>[];
      json['data'].forEach((v) {
        taskStatusCountList!.add(TaskStatusModel.fromJson(v));
      });
    }
  }
}