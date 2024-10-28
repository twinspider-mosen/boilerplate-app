import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:general_app/controllers/Auth/authentication_controller.dart';
import 'package:general_app/views/auth/login.dart';

import 'package:get/get.dart';

class SplashService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authCont = Get.put(AuthenticationController());
  isLogin(BuildContext context, {String? userRole}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 3), () {
        if (userRole == null) {
          auth.signOut().then((v) {
            Get.offAll(LoginScreen());
          });
          // Get.offAll(() => RoleScreen());
        } else {
          if (userRole == 'shop') {
            authCont.loginAsShop();
          } else {
            authCont.loginAsEmployee(auth.currentUser!.email ?? "");
          }
        }
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Get.offAll(LoginScreen());
      });
    }
  }
}
