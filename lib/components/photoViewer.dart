import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImageScreen extends StatelessWidget {
  final String imagePath;

  FullImageScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imagePath),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}
