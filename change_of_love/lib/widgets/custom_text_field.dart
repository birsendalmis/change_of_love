import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String lblText;
  final bool obscureTxt;
  final TextEditingController? fieldController;
  final FocusNode? fieldFocusNode;
  final String? Function(String?)? fieldValidator;
  final void Function(String?)? fieldOnSaved;
  const CustomTextField(
      {super.key,
      required this.lblText,
      required this.obscureTxt,
      this.fieldValidator,
      this.fieldOnSaved,
      this.fieldController,
      this.fieldFocusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      focusNode: fieldFocusNode,
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
