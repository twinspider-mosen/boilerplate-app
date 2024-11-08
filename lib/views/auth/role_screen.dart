import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/controllers/Auth/authentication_controller.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class RoleScreen extends StatelessWidget {
  final bool? isGooleLogin;
  final String? default_membership;
  final String? name;
  RoleScreen(
      {super.key, this.isGooleLogin, this.name, this.default_membership});

  @override
  Widget build(BuildContext context) {
    print(default_membership);
    double width = MediaQuery.of(context).size.width;

    return GetBuilder(
        init: AuthenticationController(),
        builder: (cont) {
          return Scaffold(
              backgroundColor: colorManager.bgColor,
              // backgroundColor: Colors.bla,
              // appBar:  ,
              appBar: AppBar(
                title: Text(
                  "Continue as",
                  style: TextStyle(
                    color: colorManager.primaryColor,
                    fontSize: 24,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        cont.logout();
                      },
                      icon: Icon(Icons.logout_outlined))
                ],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              EasyLoading.show(status: "Loading...");

                              // cont.loginAsEmployee(
                              //     cont.auth.currentUser!.email ?? "");
                            },
                            child: Container(
                              height: 130,
                              width: width * 0.42,
                              decoration: BoxDecoration(
                                  color: colorManager.primaryColor,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Employee',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: colorManager.bgColor,
                                        height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              EasyLoading.show(status: "Loading...");

                              // cont.loginAsShop(
                              //     isGoogleLogin: isGooleLogin,
                              //     default_membership: default_membership);
                              // cont.updateUserRole('shop');
                              // Get.to(() =>  CreateOrder());
                            },
                            child: Container(
                              height: 130,
                              width: width * 0.42,
                              decoration: BoxDecoration(
                                  color: colorManager.primaryColor,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Shop',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: colorManager.bgColor,
                                        height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
