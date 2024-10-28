import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class CustomDropdown4 extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> items;
  Map<String, dynamic>? selectedValue;
  final Function(Map<String, dynamic>)? onChange;

  CustomDropdown4({
    super.key,
    required this.items,
    this.onChange,
    this.selectedValue,
  });

  @override
  _CustomDropdown4State createState() => _CustomDropdown4State();
}

class _CustomDropdown4State extends State<CustomDropdown4> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        print("object");
        if (widget.items.isEmpty) {
          EasyLoading.showToast("No item available");
        } else {
          _showCustomMenu(context, widget.items, widget.onChange);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: colorManager.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.76),
              child: Text(
                widget.selectedValue?['name'] ?? 'Select an item',
                style: TextStyle(color: colorManager.textColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _showCustomMenu(
      BuildContext context,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> items,
      Function? onChange) async {
    double width = MediaQuery.of(context).size.width;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final selectedValue = await showMenu<Map<String, dynamic>>(
      color: colorManager.bgColor,
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height * 1.1,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: items.map((QueryDocumentSnapshot<Map<String, dynamic>> item) {
        return PopupMenuItem<Map<String, dynamic>>(
          value: item.data(),
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              item.data()[
                  'name'], // Replace 'displayField' with the actual field you want to display
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );

    if (selectedValue != null) {
      setState(() {
        widget.selectedValue = selectedValue;
        if (onChange != null) {
          onChange(widget.selectedValue!);
        }
      });
    }
  }
}
