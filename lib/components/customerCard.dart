import 'package:flutter/material.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class CustomerCard extends StatelessWidget {
  final String? title, subtitle;
  final VoidCallback? onTap;
  final Widget? trailing, leading;
  CustomerCard(
      {super.key,
      this.title,
      this.subtitle,
      this.leading,
      this.onTap,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(
              color: colorManager.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          onTap: onTap,
          leading: leading ??
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade100,
                child: Icon(
                  Icons.person,
                  color: colorManager.primaryColor,
                ),
              ),
          title: title != null
              ? Container(
                  constraints: BoxConstraints(minWidth: 300),
                  child: Text(
                    title!,
                    style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 18,
                        color: colorManager.textColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                )
              : null,
          subtitle: subtitle != null
              ? Text(
                  'user@email.com',
                  style: TextStyle(
                      fontFamily: 'SF Pro', fontSize: 14, color: Colors.grey),
                )
              : null,
          trailing: trailing,
        ),
      ),
    );
  }
}
