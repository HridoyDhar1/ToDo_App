// File: lib/controllers/complete_task_controller.dart

import 'package:get/get.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/model/tasklist_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class CompleteTaskController extends GetxController {
  var isLoading = false.obs;
  var completedTaskList = <TaskModel>[].obs;

  Future<void> fetchCompletedTasks() async {
    isLoading.value = true;
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      completedTaskList.value = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(Get.context!, response.errorMessage, true);
    }
    isLoading.value = false;
  }
}
