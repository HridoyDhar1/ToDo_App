import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class CreateTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isSubmitting = false.obs;
  var shouldRefreshPreviousPage = false.obs;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> addNewTask() async {
    if (formKey.currentState!.validate()) {
      isSubmitting.value = true;
      Map<String, dynamic> requestBody = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'status': 'New',
      };

      final NetworkResponse response = await NetworkCaller.postRequest(
          url: Urls.addNewTask, body: requestBody);

      isSubmitting.value = false;

      if (response.isSuccess) {
        shouldRefreshPreviousPage.value = true;
        clearFields();
        showSnackBarMessage(Get.context!, 'New task added!');
        Get.back(result: shouldRefreshPreviousPage.value);
      } else {
        showSnackBarMessage(Get.context!, response.errorMessage, true);
      }
    }
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
  }
}
