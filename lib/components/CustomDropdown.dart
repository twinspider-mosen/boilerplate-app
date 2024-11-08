import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  String? selectedValue;
  final Function(String)? onChange;
  CustomDropdown(
      {super.key, required this.items, this.onChange, this.selectedValue});
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
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
                widget.selectedValue ?? 'Select an item',
                style: TextStyle(color: colorManager.textColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: colorManager.textColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomMenu(
      BuildContext context, List<String> items, Function? onChange) async {
    double width = MediaQuery.of(context).size.width;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final selectedValue = await showMenu<String>(
      color: colorManager.greyText,
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height * 1.1,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(color: colorManager.greyText),
            child: Text(
              item,
              style: TextStyle(color: colorManager.textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );

    if (selectedValue != null) {
      setState(() {
        widget.selectedValue = selectedValue;
        // print(_selectedValue);
        onChange!(widget.selectedValue);
      });
    }
  }
}
