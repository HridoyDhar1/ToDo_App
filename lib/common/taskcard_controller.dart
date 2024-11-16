import 'package:get/get.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/services/network_response.dart';

import 'package:todo/utils/urls/urls.dart';
class TaskCardController extends GetxController {
  var changeStatusInProgress = false.obs;
  var deleteTaskInProgress = false.obs;
  var selectedStatus = ''.obs; // Ensure it's an RxString (initialized to empty string)

  @override
  void onInit() {
    super.onInit();
    // Initialize selectedStatus with a valid string value if necessary
    selectedStatus.value = ''; // Ensure it's an empty string or some default value
  }

  Future<void> changeStatus(String taskId, String newStatus) async {
    changeStatusInProgress.value = true;
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changeStatus(taskId, newStatus));
    if (response.isSuccess) {
      changeStatusInProgress.value = false;
    } else {
      changeStatusInProgress.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    deleteTaskInProgress.value = true;
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(taskId));
    if (response.isSuccess) {
      deleteTaskInProgress.value = false;
    } else {
      deleteTaskInProgress.value = false;
    }
  }
}
