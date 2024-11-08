import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/components/customInput.dart';
import 'package:pos/controllers/Auth/authentication_controller.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthenticationController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: colorManager.bgColor,
            appBar: AppBar(
              backgroundColor: colorManager.bgColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text("Create New Password"),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: controller.newPassKey,
                child: Column(
                  children: [
                    CustomInput(
                      controller: controller.passController,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: colorManager.primaryColor,
                      ),
                      obsecure: controller.obscure,
                      hint: " New Password",
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controller.showPass();
                          },
                          child: Icon(
                            controller.obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: colorManager.primaryColor,
                          )),
                    ),
                    CustomInput(
                      controller: controller.confirmController,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: colorManager.primaryColor,
                      ),
                      obsecure: controller.obscure,
                      hint: "Confirm Password",
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controller.showPass();
                          },
                          child: Icon(
                            controller.obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: colorManager.primaryColor,
                          )),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    CustomButtom(
                        label: "Create New Password",
                        onTap: () {
                          if (controller.newPassKey.currentState!.validate()) {
                            if (controller.passController.text ==
                                controller.confirmController.text) {
                              controller.updateUserPass(
                                  controller.passController.text);
                            } else {
                              EasyLoading.showToast("Password did not match!");
                            }
                          }
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
