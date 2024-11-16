import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/common/task_card.dart';
import 'package:todo/common/widgets/centeroid_circularindicator.dart';
import 'package:todo/features/todo/screens/CompleteTask/coompletetask_controller.dart';

class CompleteTask extends StatelessWidget {
  const CompleteTask({super.key});

  @override
  Widget build(BuildContext context) {

    final CompleteTaskController controller = Get.put(CompleteTaskController());

  
    controller.fetchCompletedTasks();

    return Obx(() {
      if (controller.isLoading.value) {
        return const CenteredCircularProgressIndicator();
      }
      return RefreshIndicator(
        onRefresh: controller.fetchCompletedTasks,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: controller.completedTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: controller.completedTaskList[index],
                onRefreshList: controller.fetchCompletedTasks,
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 8),
          ),
        ),
      );
    });
  }
}
