import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:general_app/controllers/theme/theme_controller.dart';
import 'package:general_app/views/dashboard/dashbaord.dart';
import 'package:general_app/views/splash/splashScreen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      title: 'BoilerPlate',
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
