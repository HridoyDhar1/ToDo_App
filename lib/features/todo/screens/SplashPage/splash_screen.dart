import 'package:flutter/material.dart';
import 'package:todo/features/todo/screens/HomePage/home_page.dart';
import 'package:todo/features/todo/screens/LoginPage/login_page.dart';
import 'package:todo/features/todo/screens/SplashPage/widgets/texts.dart';

import 'package:todo/utils/constants/texts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset("assets/images/splash.png")),
            const SizedBox(
              height: 10,
            ),
            const texts(),
            const SizedBox(
              height: 30,
            ),
            const Text(
              Texts.SplashScreenSubTitle,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00897B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15)),
                    onPressed: _singin,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sing In",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    )),
                const SizedBox(
                  width: 30,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15)),
                    onPressed:_singup,
                    child: const Text(
                      "Sing Up",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _singin(){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
}
  void _singup(){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
}
}

