import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FileUpload {
  final ImagePicker picker = ImagePicker();

  Future<void> pickAndUploadImage() async {
    // Pick an image from the gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);

      try {
        // Create a reference to Firebase Storage
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage
            .ref()
            .child('uploads/${DateTime.now().toIso8601String()}_${image.name}');

        // Upload the file
        UploadTask uploadTask = ref.putFile(file);

        // Monitor upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          double progress = snapshot.bytesTransferred / snapshot.totalBytes;
          print('Upload progress: ${progress * 100} %');
        });

        // Wait for the upload to complete
        await uploadTask.whenComplete(() => print('File Uploaded'));

        // Get the download URL
        String downloadURL = await ref.getDownloadURL();
        print('Download URL: $downloadURL');
      } catch (e) {
        print('Failed to upload image: $e');
      }
    } else {
      print('No image selected.');
    }
  }
}
