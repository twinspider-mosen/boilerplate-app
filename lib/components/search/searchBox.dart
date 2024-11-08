import 'package:flutter/material.dart';
import 'package:pos/components/CustomInputField.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final VoidCallback? onTap;
  SearchBox(
      {super.key, required this.controller, required this.title, this.onTap});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      onTap: widget.onTap,
      label: "Search ${widget.title}...",
      controller: widget.controller,
      enable: true,
      suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: colorManager.primaryColor,
          )),
    );
  }
}
