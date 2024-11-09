import 'package:flutter/material.dart';

class texts extends StatelessWidget {


  const texts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  
    RichText(
      textAlign: TextAlign.center,
      text: const
       TextSpan(
        children: [
          TextSpan(
            text: 'Create ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'Tasks And\n',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00897B), // Greenish color for 'Tasks And'
            ),
          ),
          TextSpan(
            text: 'Keep Being ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'Updated',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00897B), // Greenish color for 'Updated'
            ),
          ),
        ],
      ),
    );
  }
}
