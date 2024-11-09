import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget image; // Change from Icon to Widget
  final Color? colors;

  const CustomContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image, // Changed the parameter name to image
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: colors,
      ),
      
      child: Row(
        children: [
          const SizedBox(width: 20),
          image,  // Use image (which could be any Widget like Image or Icon)
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
