import 'package:flutter/material.dart';

import 'package:todo/features/todo/screens/SplashPage/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),);
  }
}