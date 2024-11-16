import 'package:get/get.dart';
import 'package:todo/data/controller/new_task_list_count.dart';
import 'package:todo/data/controller/singin_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
  }
}