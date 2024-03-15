import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String btntext;
  final VoidCallback onTap;
  final Color btnTxtColor;
  const CustomTextButton(
      {super.key,
      required this.btntext,
      required this.btnTxtColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: onTap,
      child: Text(
        btntext,
        style: TextStyle(color: btnTxtColor),
      ),
    );
  }
}
