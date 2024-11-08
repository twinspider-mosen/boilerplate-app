import 'package:flutter/material.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class CustomButtom extends StatelessWidget {
  final String label;
  final double labelSize;
  final VoidCallback onTap;
  Color? backgroundColor, textColr, borderColor;
  CustomButtom(
      {super.key,
      required this.label,
      this.backgroundColor,
      this.textColr,
      this.borderColor = Colors.transparent,
      required this.onTap,
      this.labelSize = 16});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: colorManager.borderColor ?? Colors.transparent),
          color: backgroundColor ?? colorManager.primaryColor,
        ),
        child: Center(
            child: Text(
          label,
          style: TextStyle(
              color: textColr ?? colorManager.bgColor, fontSize: labelSize),
        )),
      ),
    );
  }
}
