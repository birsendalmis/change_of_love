import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconsData;
  final VoidCallback onTap;
  final double? iconSize;
  final Color? iconColor;
  const CustomIconButton(
      {super.key,
      required this.iconsData,
      required this.onTap,
      required this.iconColor,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          size: iconSize,
          iconsData,
          color: iconColor,
        ));
  }
}
