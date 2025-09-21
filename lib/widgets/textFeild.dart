import 'package:flutter/material.dart';

class textFieldCustom  extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const textFieldCustom({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}



