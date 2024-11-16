import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/common/task_card.dart';
import 'package:todo/common/widgets/centeroid_circularindicator.dart';
import 'package:todo/features/todo/screens/CancelTask/cancelledtask_controller.dart';


class CancelledTask extends StatelessWidget {
  const CancelledTask({super.key});

  @override
  Widget build(BuildContext context) {
   
    final CancelledTaskController controller =
        Get.put(CancelledTaskController());

    controller.fetchCancelledTasks();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const CenteredCircularProgressIndicator();
        }
        return RefreshIndicator(
          onRefresh: controller.fetchCancelledTasks,
          child: ListView.separated(
            itemCount: controller.cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: controller.cancelledTaskList[index],
                onRefreshList: controller.fetchCancelledTasks,
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 8),
          ),
        );
      }),
    );
  }
}
