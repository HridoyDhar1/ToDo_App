import 'package:flutter/material.dart';
import 'package:todo/features/todo/screens/HomePage/widgets/custom_container.dart';

class TaskCountContainer extends StatelessWidget {
  const TaskCountContainer({
    super.key,
    required this.totalTasksCount,
    required this.inProcessTasksCount,
    required this.completedTasksCount,
    required this.canceledTasksCount,
  });

  final int totalTasksCount;
  final int inProcessTasksCount;
  final int completedTasksCount;
  final int canceledTasksCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomContainer(
              colors: Colors.teal[200],
              title: "On Going", // Now represents total tasks
              subTitle: "$totalTasksCount tasks", // Total number of tasks
              image: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/icons/work-in-progress.png")),
            ),
            const SizedBox(width: 10),
            CustomContainer(
              colors: Colors.pink[200],
              title: "In Process",
              subTitle: "$totalTasksCount tasks",
              image: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/icons/circular-arrow.png")),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomContainer(
              colors: Colors.blue[200],
              title: "Completed",
              subTitle: "$completedTasksCount tasks",
              image: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/icons/checklist.png")),
            ),
            const SizedBox(width: 10),
            CustomContainer(
              colors: Colors.orange[200],
              title: "Canceled",
              subTitle: "$canceledTasksCount tasks",
              image: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/icons/close.png")),
            ),
          ],
        ),
      ],
    );
  }
}
