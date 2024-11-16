import 'package:flutter/material.dart';
import 'package:todo/common/task_card.dart';
import 'package:todo/common/widgets/centeroid_circularindicator.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/model/tasklist_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class CancelledTask extends StatefulWidget {
  const CancelledTask({super.key});

  @override
  State<CancelledTask> createState() => _CancelledTaskState();
}

class _CancelledTaskState extends State<CancelledTask> {
   bool _getCancelledTaskListInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
                    child: Visibility(
                      visible: !_getCancelledTaskListInProgress,
                      replacement: const CenteredCircularProgressIndicator(),
                      child: RefreshIndicator(
                        onRefresh: ()async{
                          _getCompletedTaskList();
                          
      
                        },
                        
                        child: ListView.separated(
                          itemCount: _cancelledTaskList.length,
                          itemBuilder: (context, index) {
                           
                            return TaskCard(taskModel: _cancelledTaskList[index], onRefreshList: _getCompletedTaskList);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 8),
                        ),
                      ),
                    ),
                  ),
    );
  }
  Future<void> _getCompletedTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.canceledTaskList );
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}
