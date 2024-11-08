import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class ImageUpload extends StatelessWidget {
  final File image;
  final VoidCallback onTap;
  ImageUpload({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: colorManager.primaryColor, width: 1),
            image: DecorationImage(image: FileImage(image)),
            borderRadius: BorderRadius.circular(12)),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    color: colorManager.primaryColor,
                    size: 40,
                  ),
                  Text(
                    "Upload Image",
                    style: TextStyle(
                        fontSize: 16, color: colorManager.primaryColor),
                  )
                ],
              )
            : Container(),
      ),
    );
  }
}
