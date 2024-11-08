import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/views/auth/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrarController extends GetxController {
  GlobalKey profileSetting = GlobalKey();
  GlobalKey sizeSetting = GlobalKey();

  // String? selectedValue = "Rs"; // Set the default value here
  final List<String> dropdownItems = [
    'Rs',
    '\$',
  ];
  RxBool isShop = true.obs;

  String? userId;
  String? shopName;
  bool? canDelete;
  Future checkAppSettings() async {
    await FirebaseFirestore.instance
        .collection("App")
        .where('screen', isEqualTo: 'drawer')
        .get()
        .then((v) {
      canDelete = v.docs.first['can_delete'];
      update();
    });
  }

  showConfirmationDialog(
    BuildContext context,
  ) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Are you sure?",
              style: TextStyle(),
            ),
            content: Text("You want to delete your account?"),
            actions: [
              SizedBox(
                height: 40,
                width: 80,
                child: CustomButtom(label: "Yes", onTap: () {}),
              ),
              SizedBox(
                height: 40,
                width: 80,
                child: CustomButtom(
                    label: "No",
                    onTap: () {
                      Get.back();
                    }),
              )
            ],
          );
        });
  }

  final auth = FirebaseAuth.instance;

  logout() async {
    try {
      EasyLoading.show(status: "Logging out...");
      await FirebaseAuth.instance.signOut().then((v) {
        EasyLoading.dismiss();
        Get.offAll(() => LoginScreen());
      });
    } catch (e) {
      print(e);
      EasyLoading.showError("Something went wrong!");
    }
  }

  var currency;

  updateCurrency(val) async {
    currency = val;
    await SharedPreferences.getInstance().then((v) {
      v.setString("currency", currency);
    }).then((v) {
      print("Currency update: $currency");
    });
    update();
  }

  getCurrency() async {
    await SharedPreferences.getInstance().then((v) {
      currency = v.getString('currency');
      update();
    });
    print("Currency : $currency");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrency();
    checkAppSettings();
    super.onInit();
  }
}
