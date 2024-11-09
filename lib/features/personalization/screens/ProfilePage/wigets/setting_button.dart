import 'package:flutter/material.dart';

class SettingButtons extends StatelessWidget {
  final String texts;
  final String imagesIcon;
  final String images;

  const SettingButtons({
    super.key, required this.texts, required this.imagesIcon, required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
    
          children: [
            Image.asset(
             imagesIcon,
              scale: 10,
            ),
    
         Text(
              texts,
              style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.asset(
          images,
              scale: 10,
            ),
          ],
        ),
      ),
    );
  }
}
