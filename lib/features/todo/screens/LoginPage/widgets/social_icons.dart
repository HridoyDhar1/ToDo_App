import 'package:flutter/material.dart';
import 'package:todo/utils/constants/images.dart';

class Socialicons extends StatelessWidget {
  const Socialicons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          child: Image.asset(TImages.LinkdinIcon),
        ),
        const SizedBox(width: 15),
        CircleAvatar(
          child: Image.asset(TImages.GoogleIcon),
        ),
        const SizedBox(width: 15),
        CircleAvatar(
          child: Image.asset(TImages.FacbookIcon),
        ),
      ],
    );
  }
}