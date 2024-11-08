import 'package:flutter/material.dart';
import 'package:pos/components/CustomInputField.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController dateController;
  final String label;
  final String? defaultValue;
  DatePickerField(
      {super.key,
      required this.dateController,
      required this.label,
      this.defaultValue});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      readOnly: true,
      onTap: () {
        _selectDate(context, widget.dateController);
      },
      hint: widget.defaultValue,
      label: widget.label,
      enable: true,
      controller: widget.dateController,
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // The initial date for the picker
      firstDate: DateTime(1900), // The earliest date you can pick
      lastDate: DateTime(2101), // The latest date you can pick
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(selectedDate);
        // "${selectedDate.toLocal()}".split(' ')[0]; // Format: yyyy-MM-dd
      });
    }
  }
}
