import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String lblText;
  final bool obscureTxt;
  const CustomTextField(
      {super.key, required this.lblText, required this.obscureTxt});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureTxt,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        border: const OutlineInputBorder(),
        labelText: lblText,
      ),
    );
  }
}
