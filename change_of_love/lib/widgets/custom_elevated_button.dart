import 'package:change_of_love/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String btnText;
  final Color? btnTextColor;
  final double? fontSize;
  final double? btnWidth;
  final double? btnHeight;
  final Color btnColor;
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.btnTextColor = AppColors.textColorWhite,
    this.fontSize = 20,
    this.btnWidth,
    this.btnHeight,
    this.btnColor = AppColors.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(
              btnWidth ?? MediaQuery.of(context).size.width,
              btnHeight ?? MediaQuery.of(context).size.height * 0.06,
            ),
            backgroundColor: btnColor,
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Center(
            child: Text(
          btnText,
          style: TextStyle(
            fontSize: fontSize,
            color: btnTextColor,
          ),
        )));
  }
}
