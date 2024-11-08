import 'package:flutter/material.dart';
import 'package:pos/components/customerCard.dart';
import 'package:pos/main.dart';

class CustomersList extends StatelessWidget {
  CustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorManager.bgColor,
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CustomerCard();
                    }))
          ],
        ));
  }
}
