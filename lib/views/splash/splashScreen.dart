import 'package:flutter/material.dart';
import 'package:pos/controllers/theme/theme_controller.dart';
import 'package:pos/main.dart';
import 'package:pos/services/appUpdate.dart';
import 'package:pos/services/splashServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? appVersion, requiredVersion, platform;
  var updateCont = Get.put(UpdateController());
  SplashService service = SplashService();
  String? userRole;

  Future getCred() async {
    await SharedPreferences.getInstance().then((v) {
      setState(() {
        userRole = v.getString('role');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    service.isLogin(context);
    // getCred().then((v) {
    //   service.isLogin(
    //     context,
    //     userRole,
    //   );
    // });

    // updateApp();
  }

  updateApp() async {
    print('AppUpdaet');
    appVersion = await updateCont.getAppVersion();
    requiredVersion = await updateCont.getRequiredVersion();
    platform = await updateCont.checkPlatform();

    updateCont.showUpdateMessage().then((value) {
      value
          ? Future.delayed(Duration(seconds: 5), () {
              showBottomSheet();
            })
          : null;
    });
    setState(() {});
  }

  showBottomSheet() async {
    await Get.bottomSheet(Container(
      height: 190,
      decoration: BoxDecoration(
          color: colorManager.bgColor, borderRadius: BorderRadius.circular(12)),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 28.0, left: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Available',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                'You are using App version $appVersion. New Version $requiredVersion is available on ${platform == "android_app" ? "PlayStore" : "AppStore"}'),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                      updateCont.LaunchURL();
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: colorManager.primaryColor),
                    )),
                SizedBox(
                  width: 18,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: colorManager.primaryColor),
                    ))
              ],
            ),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ColorManager(),
        builder: (cont) {
          return Scaffold(
              backgroundColor: cont.bgColor,
              body: Center(
                // child: Image.asset(
                //   'assets/imgs/logo.png',
                //   height: 150,
                //   width: 150,
                child: Text(
                  "General App",
                ),
              ));
        });
  }
}
