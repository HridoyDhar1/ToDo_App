import 'package:flutter/material.dart';
import 'package:todo/common/task_card.dart';
import 'package:todo/common/widgets/centeroid_circularindicator.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/model/tasklist_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({super.key});

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
   bool _getCompletedTaskListInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return  Expanded(
                  child: Visibility(
                    visible: !_getCompletedTaskListInProgress,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: RefreshIndicator(
                      onRefresh: ()async{
                        _getCompletedTaskList();
                        

                      },
                      
                      child: ListView.separated(
                        itemCount: _completedTaskList.length,
                        itemBuilder: (context, index) {
                         
                          return TaskCard(taskModel: _completedTaskList[index], onRefreshList: _getCompletedTaskList);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 8),
                      ),
                    ),
                  ),
                );
  }
  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompletedTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _completedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompletedTaskListInProgress = false;
    setState(() {});
  }
}
