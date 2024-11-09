import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String valid;
  final IconData icons;
  final TextInputType keyboardTypes;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.name,
    required this.icons,
    required this.keyboardTypes, required this.controller, required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            name,
            style: const TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String?value){
            if(value?.isEmpty??true){
              return valid;
            }return null;
          },
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: Icon(icons),
             
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        )
      ],
    );
  }
}
