import 'package:change_of_love/constants/colors.dart';
import 'package:flutter/material.dart';

class ListsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String btnText;
  final Color? btnTextColor;
  final double? fontSize;
  final double? btnWidth;
  final double? btnHeight;
  final Color? btnColor;

  const ListsButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.btnTextColor,
    this.fontSize,
    this.btnWidth,
    this.btnHeight,
    this.btnColor = AppColors.listButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(
            btnWidth ?? MediaQuery.of(context).size.width,
            btnHeight ?? MediaQuery.of(context).size.height * 0.06,
          ),
          // backgroundColor: AppColors.listButtonColor,
          backgroundColor: btnColor,
          elevation: 1.0,
          side: const BorderSide(color: Color.fromARGB(255, 214, 199, 179)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      onPressed: onTap,
      child: Text(
        btnText,
        style: TextStyle(
          fontSize: fontSize,
          color: btnColor == AppColors.listButtonColor
              ? btnTextColor
              : Colors.white,
        ),
      ),
    );
  }
}
