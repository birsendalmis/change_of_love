import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String lblText;
  final bool obscureTxt;
  final String? Function(String?)? fieldValidator;
  final void Function(String?)? fieldOnSaved;
  const CustomTextField(
      {super.key,
      required this.lblText,
      required this.obscureTxt,
      this.fieldValidator,
      this.fieldOnSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: fieldValidator,
      onSaved: fieldOnSaved,
      obscureText: obscureTxt,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        border: const OutlineInputBorder(),
        labelText: lblText,
      ),
    );
  }
}
