import 'package:flutter/material.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final String customerName, customerAddress, image, deadline, orderID;
  final VoidCallback onTap;
  OrderCard(
      {super.key,
      required this.customerName,
      required this.customerAddress,
      required this.image,
      required this.onTap,
      required this.orderID,
      required this.deadline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
              border: Border.all(color: colorManager.borderColor, width: 1)),
          child: ListTile(
              leading: image != ""
                  ? Container(
                      height: 60,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
                          color: Colors.grey.shade200),
                    )
                  : Icon(
                      Icons.shopping_bag_outlined,
                      color: colorManager.primaryColor,
                      size: 40,
                    ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 160),
                    child: Text("$customerName ",
                        style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: colorManager.textColor,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis)),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 40),
                    child: Text(orderID,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: colorManager.textColor,
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      customerAddress,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                  ),
                  Text(
                    deadline,
                    style: TextStyle(
                        fontFamily: 'SF Pro', fontSize: 12, color: Colors.grey),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
