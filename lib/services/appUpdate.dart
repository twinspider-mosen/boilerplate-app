import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateController extends GetxController {
  checkPlatform() {
    if (Platform.isAndroid) {
      var platform = "android_app";
      return platform;
    } else {
      var platform = "ios_app";

      return platform;
    }
  }

  getRequiredVersion() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('App')
          .where('screen', isEqualTo: 'update')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        if (Platform.isAndroid) {
          // return
          String version = doc['android_version'] ?? 'Unknown';
          print(version);
          return version;
        } else {
          String version = doc['ios_version'] ?? 'Unknown';
          print(version);
          return version;
        }
      } else {
        print('No documents found.');
        return "";
      }
    } catch (e) {
      print('Error fetching required version: $e');
      return "";
    }
  }

  String serverVersion = "";
  getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    var appVersion = packageInfo.version;
    print(appVersion);
    return appVersion;
  }

  showUpdateMessage() async {
    var oldVersion = await getAppVersion();
    var newVersion = await getRequiredVersion();
    int appVersion = int.parse(oldVersion.replaceAll(".", ""));
    int updatedVersion = int.parse(newVersion.replaceAll(".", ""));
    print("Old Version : $appVersion");
    print("New Version : $updatedVersion");

    if (appVersion < updatedVersion) {
      return true;
    } else {
      return false;
    }
  }

  LaunchURL() async {
    String url = "";
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=';
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/ca/app/id';
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
