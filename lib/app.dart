import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo/features/todo/screens/SplashPage/splash_screen.dart';

class MyApp extends StatelessWidget {
 
  const MyApp({super.key});
  static GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return 

    
     const GetMaterialApp(
    
      
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      );
  }
}