import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/controllers/theme/theme_controller.dart';
import 'package:pos/views/dashboard/dashbaord.dart';
import 'package:pos/views/splash/splashScreen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isWindows){
    await Firebase.initializeApp(
     options: FirebaseOptions( apiKey: 'AIzaSyA-ouUuMf4UM_hzmTP0zYFHh6_2aDzhRPU',
    appId: '1:995256357123:web:b0d3fe270afb01e9e85936',
    messagingSenderId: '995256357123',
    projectId: 'point-of-sale-b9555',
    authDomain: 'point-of-sale-b9555.firebaseapp.com',
    storageBucket: 'point-of-sale-b9555.firebasestorage.app',
    measurementId: 'G-KL4PV2X4S7',)
    );
  }
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(const MyApp());
}

final colorManager = Get.put(ColorManager());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Point Of Sale ',
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
