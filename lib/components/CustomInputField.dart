import 'package:flutter/material.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class CustomInputField extends StatefulWidget {
  final String? label, hint;
  final bool enable;
  final FocusNode? focusNode;
  final Widget? suffixIcon, prefixIcon;
  final TextInputType type;
  final bool readOnly;
  final bool obsecure;

  // final VoidCallback;
  final Function(String)? onChanged;
  VoidCallback? onTap;
  final TextEditingController? controller;

  final int maxLine;
  CustomInputField(
      {super.key,
      this.maxLine = 1,
      this.enable = true,
      this.controller,
      this.obsecure = false,
      this.focusNode,
      this.readOnly = false,
      this.type = TextInputType.text,
      this.hint,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.onTap,
      this.label});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  void initState() {
    super.initState();
    if (widget.controller != null && widget.hint != null) {
      widget.controller!.text = widget.hint!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: GestureDetector(
        onTap: () {
          widget.onTap;
        },
        child: TextFormField(
          style: TextStyle(color: colorManager.textColor),
          obscureText: widget.obsecure,
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          keyboardType: widget.type,
          enabled: widget.enable,
          onChanged: (value) {
            widget.onChanged != null ? widget.onChanged!(value) : null;
          },
          validator: (value) {
            return value!.isEmpty ? "${widget.label} can't be empty!" : null;
          },
          controller: widget.controller,
          cursorColor: colorManager.primaryColor,
          maxLines: widget.maxLine,
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              labelText: widget.label,
              suffixIcon: widget.suffixIcon,
              hintText:
                  widget.label != null ? "Enter ${widget.label}" : widget.hint,
              hintStyle: TextStyle(
                  color: Colors.grey.shade500, fontWeight: FontWeight.w300),
              floatingLabelStyle: TextStyle(
                  fontFamily: 'SF Pro',
                  color: colorManager.primaryColor,
                  fontSize: 18),
              contentPadding: EdgeInsets.only(left: 18, top: 18, bottom: 18),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorManager.borderColor),
                  borderRadius: BorderRadius.circular(16)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(16)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorManager.primaryColor),
                  borderRadius: BorderRadius.circular(16)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorManager.borderColor),
                  borderRadius: BorderRadius.circular(16)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colorManager.primaryColor)),
              // label: Text("data"),
              labelStyle: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 16,
                  color: colorManager.primaryColor)),
        ),
      ),
    );
  }
}
