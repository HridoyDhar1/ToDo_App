import 'package:flutter/material.dart';
import 'package:todo/common/custom_elevated_button.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/controller/auth_controller.dart';
import 'package:todo/data/model/login_model.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/features/todo/screens/HomePage/home_page.dart';

import 'package:todo/features/todo/screens/LoginPage/widgets/form_field.dart';
import 'package:todo/features/todo/screens/LoginPage/widgets/social_icons.dart';
import 'package:todo/features/todo/screens/SingupPage/singup_screen.dart';
import 'package:todo/features/todo/screens/VerifyPage/verify_page.dart';

import 'package:todo/utils/constants/texts.dart';
import 'package:todo/utils/urls/urls.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _inProgress=false;
  final GlobalKey<FormState>_formKey=GlobalKey();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  Texts.LoginScreenTitle,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  Texts.LoginScreenSubTitle,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 50),
            
                CustomTextField(
                  controller: emailsController,
                  name: 'Email',
                  keyboardTypes: TextInputType.text,
                  icons: Icons.email,
                  valid: 'Enter valid email',
                ),
                const SizedBox(height: 10),
            
                CustomTextField(
                  controller: passwordController,
                  name: 'Password',
                  keyboardTypes: TextInputType.text,
                  icons: Icons.email,
                  valid: 'Enter the 8 digit  password',
                ),
            
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: _forgetPassowrd,
                      child: const Text(
                        Texts.ForgetPassword,
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      )),
                ),
                const SizedBox(height: 20),
                CustomElevatedbutton(
                    hSize: 150,
                    vSize: 15,
                    onPressed: _onTapNextButton,
                    name: "Sing In",
                    textColor: Colors.white),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 1,
                    )),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                    )),
                  ],
                ),
                const SizedBox(height: 30),
            // Social Icon ..
                const Socialicons(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      Texts.HavenotYet,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    TextButton(
                        onPressed: _createaccount,
                        child: const Text(
                          Texts.CreateAccount,
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _onTapNextButton() {
if(!_formKey.currentState!.validate()){
return ;
}
_signIn();
  }

  // api call for singin ///

Future<void> _signIn() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      'email' : emailsController.text.trim(),
      'password' : passwordController.text,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.login, body: requestBody);
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!.first);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (value) => false,
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
  void _createaccount() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SingupScreen()));
  }

  void _forgetPassowrd() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const VerificationPage()));
  }
}
