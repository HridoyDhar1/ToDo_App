import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo/features/todo/screens/CreateTask/createtask_controller.dart';
import 'package:todo/features/todo/screens/LoginPage/widgets/form_field.dart';

class CreateTasks extends StatelessWidget {
  const CreateTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateTaskController controller = Get.put(CreateTaskController());

    return WillPopScope(
      onWillPop: () async => false,
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
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomTextField(
                      name: "Title",
                      icons: Icons.person,
                      keyboardTypes: TextInputType.text,
                      controller: controller.titleController,
                      valid: 'Enter the title',),
                  const SizedBox(height: 10),
                  CustomTextField(
                      name: 'Description',
                      icons: Icons.description,
                      keyboardTypes: TextInputType.text,
                      controller: controller.descriptionController,
                      valid: 'Enter the description'),
                  const SizedBox(height: 20),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: controller.isSubmitting.value
                                ? null
                                : controller.addNewTask,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: controller.isSubmitting.value
                                      ? Colors.grey
                                      : Colors.blueAccent),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
