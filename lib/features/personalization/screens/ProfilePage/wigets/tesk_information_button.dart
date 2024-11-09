import 'package:flutter/material.dart';
import 'package:todo/features/personalization/screens/ProfilePage/edit_profile.dart';

class TaskinformationButton extends StatelessWidget {
  const TaskinformationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    String name = "John Doe";
    String email = "john.doe@example.com";
    String password = "123456";

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        SizedBox(
          width: 150,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color.fromARGB(255, 44, 5, 171)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                              name: name,
                              email: email,
                              password: password,
                            )));
              },
              child: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 50,
            width: 380,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Icon(Icons.settings,
                    size: 30, color: Color.fromARGB(255, 44, 5, 171)),
                SizedBox(width: 20),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 150),
                Icon(Icons.arrow_right_rounded, size: 30),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 50,
            width: 380,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Icon(Icons.settings,
                    size: 30, color: Color.fromARGB(255, 44, 5, 171)),
                SizedBox(width: 20),
                Text(
                  "Support",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 150),
                Icon(Icons.arrow_right_rounded, size: 30),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 50,
            width: 380,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Icon(Icons.notifications,
                    size: 30, color: Color.fromARGB(255, 44, 5, 171)),
                SizedBox(width: 20),
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 120),
                Icon(Icons.arrow_right, size: 30),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 50,
            width: 380,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Icon(
                  Icons.settings,
                  size: 30,
                  color: Color.fromARGB(255, 44, 5, 171),
                ),
                SizedBox(width: 20),
                Text(
                  "Log Out",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 150),
                Icon(Icons.arrow_right_rounded, size: 30),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
