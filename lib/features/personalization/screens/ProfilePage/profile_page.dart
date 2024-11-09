import 'package:flutter/material.dart';

import 'package:todo/features/personalization/screens/ProfilePage/wigets/tesk_information_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
       
        body:const Column(
          children: [
      SizedBox(height: 10),
         Center(
              child: CircleAvatar(
                radius: 50,
                foregroundImage: AssetImage("assets/icons/man-removebg-preview.png"),
              ),
            ),
         SizedBox(height: 20),
          Text(
              "RadhaKrishna",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
        SizedBox(height: 5),
        Text(
              "Software Developer",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),
            TaskinformationButton(),
            
      
                    ],
        ),
      ),
    );
  }
}

