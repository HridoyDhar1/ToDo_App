import 'package:flutter/material.dart';
import 'package:todo/common/widgets/centeroid_circularindicator.dart';

import 'package:todo/common/widgets/snack_bar.dart';
import 'package:todo/data/model/network_response.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/services/network_response.dart';
import 'package:todo/utils/urls/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
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
          widget.taskModel.title ?? 'No Title',
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
              widget.taskModel.description ?? 'No Description',
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              'Status: ${widget.taskModel.status ?? 'No Status'}',
              style: const TextStyle(color: Colors.black54),
            ),
            Text(
              'Date: ${widget.taskModel.createdDate ?? ''}',
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !_changeStatusInProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: IconButton(
                onPressed: _onTapEditButton,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
            Visibility(
              visible: !_deleteTaskInProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: IconButton(
                onPressed: _onTapDeleteButton,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

void _onTapEditButton() {
  _showEditDialog(context);
}

void _showEditDialog(BuildContext context) {
  String currentStatus = _selectedStatus;

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
                  setState(() {
                    _selectedStatus = currentStatus;
                  });
                  _changeStatus(currentStatus);  // Call method to change status
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


  Future<void> _onTapDeleteButton() async {
    _deleteTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel.sId!));
    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _deleteTaskInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  Future<void> _changeStatus(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changeStatus(widget.taskModel.sId!, newStatus));
    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
