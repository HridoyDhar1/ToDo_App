import 'package:flutter/material.dart';
import 'package:todo/common/task_card.dart';
import 'package:todo/common/widgets/centeroid_circularindicator.dart';
import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/model/taskcount_model.dart';
import 'package:todo/data/model/tasklist_model.dart';
import 'package:todo/data/model/taskstatus_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/features/todo/screens/HomePage/create_task.dart';
import 'package:todo/features/todo/screens/HomePage/widgets/task_count_container.dart';
import 'package:todo/utils/urls/urls.dart';

class HomePageContents extends StatefulWidget {
  final List<Map<String, String>> tasks;

  const HomePageContents({
    super.key,
    required this.tasks,
  });

  @override
  _HomePageContentsState createState() => _HomePageContentsState();
}

class _HomePageContentsState extends State<HomePageContents> {
  bool _getNewTaskListInProgress = false;
  List<TaskModel> _newTaskList = [];
  bool _getTaskStatusCountListInProgress = false;
  List<TaskStatusModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    int totalTasksCount = _newTaskList.length;
    int inProcessTasksCount =
        _newTaskList.where((task) => task.status == 'inProcess').length;
    int completedTasksCount =
        _newTaskList.where((task) => task.status == 'Completed').length;
    int canceledTasksCount =
        _newTaskList.where((task) => task.status == 'Cancelled').length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.logout, color: Colors.black),
              ),
            ],
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            elevation: 1.0,
          ),
        ],
        
        body: RefreshIndicator(
          onRefresh: () async {
            _getNewTaskList();
            _getTaskStatusCount();
          
          },
          
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TaskCountContainer(
                  totalTasksCount: totalTasksCount,
                  inProcessTasksCount: inProcessTasksCount,
                  completedTasksCount: completedTasksCount,
                  canceledTasksCount: canceledTasksCount,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Recently Tasks",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Visibility(
                    visible: !_getNewTaskListInProgress,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ListView.separated(
                      itemCount: _newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskModel: _newTaskList[index],
                          onRefreshList: _getNewTaskList,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CreateTasks();
          },
        );
      },
      child: const Icon(Icons.add),
    ),
  );
    
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.newTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getNewTaskListInProgress = false;
    setState(() {});
  }

  void _showEditDialog(
      BuildContext context, int index, Map<String, String> task) {
    String currentStatus = task['status'] ?? 'ongoing';

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
                    value: 'completed',
                    groupValue: currentStatus,
                    onChanged: (value) {
                      setState(() {
                        currentStatus = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Canceled'),
                    value: 'canceled',
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
                    setState(() {
                      widget.tasks[index]['status'] = currentStatus;

                    });
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

  Future<void> _getTaskStatusCount() async {
    _taskStatusCountList.clear();
    _getTaskStatusCountListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
          
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getTaskStatusCountListInProgress = false;
    setState(() {});
  }
  
}
