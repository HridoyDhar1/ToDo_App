import 'package:get/get.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/model/taskcount_model.dart';
import 'package:todo/data/model/tasklist_model.dart';
import 'package:todo/data/model/taskstatus_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class HomeController extends GetxController {
  var newTaskList = <TaskModel>[].obs;
  var taskStatusCountList = <TaskStatusModel>[].obs;
  var isLoading = true.obs;

  // Get task list
  Future<void> getNewTaskList() async {
    isLoading(true);
    final response = await NetworkCaller.getRequest(url: Urls.newTaskList);
    if (response.isSuccess) {
      final taskListModel = TaskListModel.fromJson(response.responseData);
      newTaskList.value = taskListModel.taskList ?? [];
    } else {
      // Show error
    }
    isLoading(false);
  }

  // Get task status count
  Future<void> getTaskStatusCount() async {
    final response = await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      final taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      taskStatusCountList.value = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      // Show error
    }
  }
}
