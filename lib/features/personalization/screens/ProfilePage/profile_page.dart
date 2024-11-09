import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/common/custom_elevated_button.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/controller/auth_controller.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/user_model.dart';
import 'package:todo/data/services/network_response.dart';

import 'package:todo/features/todo/screens/LoginPage/widgets/form_field.dart';
import 'package:todo/utils/urls/urls.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.mobile ?? '';
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _selectedImage != null
                          ? FileImage(File(_selectedImage!.path))
                          : const AssetImage("assets/icons/man-removebg-preview.png") as ImageProvider,
                    ),
                  ),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text("Update Image"),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    
                      name: "Name",
                      icons: Icons.person,
                      keyboardTypes: TextInputType.text,
                      controller: _firstNameTEController,
                      hintText: _firstNameTEController.text.isEmpty ? "Enter your name" : _firstNameTEController.text,
                      valid: 'Enter the value'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      name: "Email",
                      icons: Icons.email,
                      keyboardTypes: TextInputType.emailAddress,
                      controller: _emailTEController,
                      hintText: _emailTEController.text.isEmpty ? "Enter your email" : _emailTEController.text,
                      valid: 'Enter the email'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      name: "Password",
                      icons: Icons.lock,
                      keyboardTypes: TextInputType.visiblePassword,
                      controller: _passwordTEController,
                      hintText: "Enter new password",
                      valid: 'Enter the password'),
                  const SizedBox(height: 20),
                  CustomElevatedbutton(
                      hSize: 150,
                      vSize: 15,
                      onPressed: _updateButton,
                      name: "Update",
                      textColor: Colors.white)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
      "password":_passwordTEController.text
    };

    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      showSnackBarMessage(context, 'Profile has been updated!');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
