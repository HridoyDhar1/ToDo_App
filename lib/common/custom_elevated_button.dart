import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
  final double hSize;
  final double vSize;
  final VoidCallback onPressed;
  final String name;
  final Color textColor;
  const CustomElevatedbutton({super.key, required this.hSize, required this.vSize, required this.onPressed, required this.name, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:  EdgeInsets.symmetric(
                          horizontal: hSize, vertical: vSize),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.teal),
                  onPressed: onPressed,
                  child:  Text(
                    name,
                    style: TextStyle(color: textColor),
                  ));
  }
}