import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/common/taskcard_controller.dart';
import 'package:todo/common/widgets/centeroid_circularindicator.dart';

import 'package:todo/data/model/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final TaskCardController controller = Get.put(TaskCardController());

    // Initialize the status from the task model
    controller.selectedStatus.value = taskModel.status ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[800],
          child: const Icon(
            Icons.work,
            color: Colors.white,
          ),
        ),
        title: Text(
          taskModel.title ?? 'No Title',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskModel.description ?? 'No Description',
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              'Status: ${taskModel.status ?? 'No Status'}',
              style: const TextStyle(color: Colors.black54),
            ),
            Text(
              'Date: ${taskModel.createdDate ?? ''}',
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return Visibility(
                visible: !controller.changeStatusInProgress.value,
                replacement: const CenteredCircularProgressIndicator(),
                child: IconButton(
                  onPressed: () => _onTapEditButton(context, controller),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: !controller.deleteTaskInProgress.value,
                replacement: const CenteredCircularProgressIndicator(),
                child: IconButton(
                  onPressed: () => _onTapDeleteButton(controller),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _onTapEditButton(BuildContext context, TaskCardController controller) {
    _showEditDialog(context, controller);
  }

  void _showEditDialog(BuildContext context, TaskCardController controller) {
    String currentStatus = controller.selectedStatus.value;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Task Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('Completed'),
                    value: 'Completed',
                    groupValue: currentStatus,
                    onChanged: (value) {
                      setState(() {
                        currentStatus = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Cancelled'),
                    value: 'Cancelled',
                    groupValue: currentStatus,
                    onChanged: (value) {
                      setState(() {
                        currentStatus = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    controller.selectedStatus.value = currentStatus;
                    controller.changeStatus(taskModel.sId!, currentStatus);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _onTapDeleteButton(TaskCardController controller) async {
    controller.deleteTask(taskModel.sId!);
  }
}
