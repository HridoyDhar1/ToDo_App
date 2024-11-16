import 'package:get/get.dart';

import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/model/tasklist_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class NewTaskListController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  List<TaskModel> _taskList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<TaskModel> get taskList => _taskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.newTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}