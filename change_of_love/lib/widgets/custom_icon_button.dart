import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconsData;
  final VoidCallback onTap;
  final Color? iconColor;
  const CustomIconButton(
      {super.key,
      required this.iconsData,
      required this.onTap,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          iconsData,
          color: iconColor,
        ));
  }
}
