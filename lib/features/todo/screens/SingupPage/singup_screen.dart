// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:todo/common/custom_elevated_button.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/features/todo/screens/LoginPage/widgets/form_field.dart';

import 'package:todo/features/todo/screens/LoginPage/widgets/social_icons.dart';

import 'package:todo/utils/constants/texts.dart';
import 'package:todo/utils/urls/urls.dart';

import '../../../../data/services/network_response.dart';

class SingupScreen extends StatefulWidget {

  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailsController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrimPasswordController =
      TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  bool _isProgress = false;
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
                const SizedBox(height: 50),
                const Text(
                  Texts.SingUpTitle,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 50),
                CustomTextField(
                    controller: firstNameController,
                    name: "Full Name",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.person,
                    valid: 'Enter the name'),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: emailsController,
                    valid: 'Enter valid email',
                    name: "Email",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.email),
                const SizedBox(height: 10),
                CustomTextField(
                    valid: 'Enter the password',
                    controller: passwordController,
                    name: "Password",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.lock),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    valid: 'Enter the password',
                    controller: confrimPasswordController,
                    name: "Confirm Password",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.lock),

                const SizedBox(height: 20),
                CustomElevatedbutton(
                    hSize: 150,
                    vSize: 15,
                    onPressed:_onTapNextButton,
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
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    _isProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": emailsController.text.trim(),
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "mobile": mobileController.text.trim(),
      "password": passwordController.text,
      "photo": ""
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.resgistration,
      body: requestBody,
    );
    _isProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New user created');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextFields() {
    emailsController.clear();
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
    confrimPasswordController.clear();
  }


  @override
  void dispose() {
    emailsController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confrimPasswordController.dispose();
    super.dispose();
  }
}
