import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  CustomTextFeild(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.color});
   TextEditingController controller;
  String hintText;
  Color color;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          hintStyle: TextStyle(color: color)),
    );
  }
}
