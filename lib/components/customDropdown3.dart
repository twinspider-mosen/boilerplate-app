import 'package:flutter/material.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class CustomDropdown3 extends StatefulWidget {
  final Map<String, dynamic> items;
  final Function(dynamic, dynamic)? onChange;

  CustomDropdown3({
    super.key,
    required this.items,
    this.onChange,
  });

  @override
  _CustomDropdown3State createState() => _CustomDropdown3State();
}

class _CustomDropdown3State extends State<CustomDropdown3> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _showCustomMenu(context, widget.items, widget.onChange);
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
                _selectedValue ?? 'Select an item',
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
    Map<String, dynamic> items,
    Function(dynamic, dynamic)? onChange,
  ) async {
    if (items.isEmpty) {
      // Handle the case where there are no items
      print('No items to display in the menu');
      return;
    }

    double width = MediaQuery.of(context).size.width;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final selectedKey = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: items.keys.map((String key) {
        return PopupMenuItem<String>(
          value: key,
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              key, // Display the key
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );

    if (selectedKey != null) {
      setState(() {
        _selectedValue = selectedKey;
        final selectedValue = items[selectedKey];
        if (onChange != null) {
          onChange(selectedKey, selectedValue);
        }
      });
    }
  }
}
