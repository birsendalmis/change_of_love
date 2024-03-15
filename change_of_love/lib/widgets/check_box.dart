import 'package:change_of_love/constants/colors.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  final String txt;
  const CheckBox({super.key, required this.txt});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.darkGreyColor)),
                child: _isSelected
                    ? const Icon(
                        Icons.check,
                        size: 17,
                        color: Colors.green,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(widget.txt),
          ],
        )
      ],
    );
  }
}
