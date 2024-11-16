import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/model/login_model.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';
import 'package:todo/data/controller/auth_controller.dart';
import 'package:todo/features/todo/screens/HomePage/home_page.dart';

import 'package:todo/common/widgets/snack_bar.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isInProgress = false.obs;
  var formKey = GlobalKey<FormState>().obs;

  void signIn(BuildContext context) async {
    if (!formKey.value.currentState!.validate()) {
      return;
    }
    isInProgress.value = true;
    Map<String, dynamic> requestBody = {
      'email': email.value.trim(),
      'password': password.value,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(url: Urls.login, body: requestBody);
    isInProgress.value = false;
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!.first);
      Get.offAll(() => const HomePage());
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
