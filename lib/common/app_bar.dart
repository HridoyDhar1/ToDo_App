import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.tasks,
  });

  final List<Map<String, String>> tasks;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Text(
            "${tasks.length} pending tasks", // Dynamic task count
            style: const TextStyle(fontSize: 15, color: Colors.teal),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage:
                AssetImage("assets/icons/man-removebg-preview.png"),
            radius: 25,
          ),
        ),
      ],
    );
  }
}
