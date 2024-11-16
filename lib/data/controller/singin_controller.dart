import 'package:get/get.dart';
import 'package:todo/data/controller/auth_controller.dart';
import 'package:todo/data/model/login_model.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/user_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestBody);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data! as UserModel);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}