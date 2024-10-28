import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorManager extends GetxController {
  Color primaryColor = Color(0xff1B6F72);
  Color textColor = Color(0xff161616);
  Color iconColor = Color(0xff1B6F72);

  Color greyText = Colors.grey.shade200;
  Color bgColor = Color(0xffffffff);
  Color borderColor = Color.fromARGB(255, 217, 217, 217);

  lightTheme() {
    textColor = Color(0xff161616);
    greyText = Colors.grey.shade200;
    bgColor = Color(0xffffffff);
    iconColor = primaryColor;
    Get.changeTheme(ThemeData.light());

    borderColor = Color.fromARGB(255, 217, 217, 217);
    update();
  }

  darkTheme() {
    textColor = Colors.white;
    greyText = primaryColor;
    bgColor = Color(0xff161616);
    iconColor = Colors.white;
    Get.changeTheme(ThemeData.dark());
    borderColor = Color.fromARGB(255, 217, 217, 217);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadThemeFromPreferences();
    getUserRole();
  }

  bool isDark = false;
  void toggleTheme(newVal) {
    isDark = newVal;
    // isDarkTheme.value = newVal;
    isDark ? darkTheme() : lightTheme();
    saveThemeToPreferences(isDark);
    update();
  }

  void loadThemeFromPreferences() async {
    await SharedPreferences.getInstance().then((v) {
      isDark = v.getBool('isDarkTheme') ?? false;
      isDark ? darkTheme() : lightTheme();
      print("Id Dark theme:  $isDark");
      update();
    });
  }

  void saveThemeToPreferences(bool isDarkTheme) async {
    await SharedPreferences.getInstance().then((v) {
      v.setBool('isDarkTheme', isDarkTheme);
      update();
    });
  }

  void getUserRole() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      await SharedPreferences.getInstance().then((v) {
        var role = v.get("role");
        primaryColor = role == "shop"
            ? Color(0xff1B6F72)
            : Color.fromARGB(255, 180, 104, 27);
        // Update the theme after setting the primary color
        isDark ? darkTheme() : lightTheme();
        update();
      });
    } else {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          var role = snapshot.data()!['role'];
          primaryColor = role == "shop"
              ? Color(0xff1B6F72)
              : Color.fromARGB(255, 180, 104, 27);
          // Update the theme after setting the primary color
          isDark ? darkTheme() : lightTheme();
          update();
        } else {
          print('No user found');
        }
      }, onError: (error) {
        print('Error: $error');
      });
    }
  }
}
