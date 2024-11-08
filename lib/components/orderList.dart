import 'package:flutter/material.dart';
import 'package:pos/components/search/searchBox.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class OrderList extends StatelessWidget {
  var data, controller, title;

  OrderList(
      {super.key,
      required this.data,
      required this.controller,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorManager.bgColor,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchBox(
                controller: controller.searchController,
                title: title,
              ),
              data
            ],
          ),
        ));
  }
}
