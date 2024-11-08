import 'package:flutter/material.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class CustomToggleButton extends StatefulWidget {
  final String title_1, title_2;
  final ValueChanged<bool> onToggle;

  CustomToggleButton(
      {super.key,
      required this.title_1,
      required this.title_2,
      required this.onToggle});
  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool isToggled = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isToggled = !isToggled;
          widget.onToggle(isToggled);
        });
      },
      child: Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: isToggled ? colorManager.primaryColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: isToggled
              ? Text(
                  widget.title_1,
                  key: ValueKey<bool>(isToggled),
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  widget.title_2,
                  key: ValueKey<bool>(isToggled),
                  style: TextStyle(color: colorManager.primaryColor),
                ),
        ),
      ),
    );
  }
}
