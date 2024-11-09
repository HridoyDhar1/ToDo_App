import 'package:flutter/material.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/services/network_response.dart';

import 'package:todo/features/todo/screens/LoginPage/widgets/form_field.dart';
import 'package:todo/utils/urls/urls.dart';

class CreateTasks extends StatefulWidget {
  const CreateTasks({super.key});

  @override
  State<CreateTasks> createState() => _CreateTasksState();
}

class _CreateTasksState extends State<CreateTasks> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;
  bool _shouldRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
      },
      child: AlertDialog(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            "New Task",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomTextField(
                      name: "Title",
                      icons: Icons.person,
                      keyboardTypes: TextInputType.text,
                      controller: _titleTEController,
                      valid: 'Enter the title'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      name: 'Description',
                      icons: Icons.description,
                      keyboardTypes: TextInputType.text,
                      controller: _descriptionTEController,
                      valid: 'Enter the description'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: _onTapSubmitButton,
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.blueAccent),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
   
    if (_formKey.currentState!.validate()) {
      _addNewTask().then((_){
        Navigator.pop(context,_shouldRefreshPreviousPage);
      });
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'title': _titleTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      'status': 'New',
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.addNewTask, body: requestBody);

    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _shouldRefreshPreviousPage = true;
      _clearTextFields();
      showSnackBarMessage(context, 'New task added!');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
