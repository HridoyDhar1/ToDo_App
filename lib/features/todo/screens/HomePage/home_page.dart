import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/features/personalization/screens/ProfilePage/profile_page.dart';
import 'package:todo/features/todo/screens/CancelTask/cancel_task.dart';
import 'package:todo/features/todo/screens/CompleteTask/complete_task.dart';

import 'package:todo/features/todo/screens/HomePage/widgets/homepage_content.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _selectDate;
  final TextEditingController _dateController = TextEditingController();
  List<Map<String, String>> tasks = []; // Initialized here

  // Method for date picker....
  Future<void> _selectDated(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != _selectDate) {
      setState(() {
        _selectDate = picked;
        String formattedDate =
            DateFormat('EEEE, dd/MM/yyyy').format(_selectDate!);
        // Update the text field with the formatted date
        _dateController.text = formattedDate;
      });
    }
  }

  void _addNewTask(Map<String, String> task) {
    setState(() {
      tasks.add(task); // Add the new task
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePageContents(tasks: tasks),
      const CompleteTask(),
      const CancelledTask(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.check_box), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

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
