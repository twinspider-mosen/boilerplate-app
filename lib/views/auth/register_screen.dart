import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/components/customInput.dart';
import 'package:pos/components/customToggleButton.dart';
import 'package:pos/controllers/Auth/authentication_controller.dart';
import 'package:pos/main.dart';
import 'package:pos/utility/constants.dart';
import 'package:pos/views/auth/login.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GetBuilder(
        init: AuthenticationController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: colorManager.bgColor,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/imgs/logo.png',
                        //   height: 150,
                        // ),
                        Text(
                          "BoilerPlate App",
                          style: TextStyle(
                              color: colorManager.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 42),
                        ),
                        SizedBox(height: 20),

                        CustomInput(
                          controller: controller.nameController,
                          prefixIcon: Icon(
                            Icons.person,
                            color: colorManager.primaryColor,
                          ),
                          hint: "Your Full Name",
                        ),
                        CustomInput(
                          isRequired: false,
                          controller: controller.emailController,
                          prefixIcon: Icon(
                            Icons.email,
                            color: colorManager.primaryColor,
                          ),
                          hint: "Email",
                        ),
                        CustomInput(
                          controller: controller.phoneController,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: colorManager.primaryColor,
                          ),
                          hint: "Phone",
                        ),
                        CustomInput(
                          controller: controller.passController,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: colorManager.primaryColor,
                          ),
                          obsecure: controller.obscure,
                          hint: "Password",
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
                          height: 20,
                        ),
                        CustomButtom(
                            label: "Create Account",
                            onTap: () {
                              if (controller.registerFormKey.currentState!
                                  .validate()) {
                                prettyPrint({
                                  'name': controller.nameController.text,
                                  'email': controller.emailController.text,
                                  'phone': controller.phoneController.text,
                                  'pass': controller.passController.text
                                });
                                if (controller.phoneController.text.length <
                                    (kDebugMode ? 4 : 10)) {
                                  EasyLoading.showError("Invalid Phone");
                                } else {
                                  controller.createAccount();
                                }
                              }
                            }),
                        SizedBox(height: 28),
                        RichText(
                          text: TextSpan(
                              text: "Already have an Account? ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorManager.textColor,
                                  letterSpacing: 1),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.offAll(() => LoginScreen());
                                      },
                                    text: "Login",
                                    style: TextStyle(
                                        color: colorManager.primaryColor))
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CircularButton extends StatelessWidget {
  final String logo;
  final VoidCallback onTap;
  CircularButton({super.key, required this.logo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: colorManager.borderColor,
            ),
            borderRadius: BorderRadius.circular(50)),
        child: SvgPicture.asset(
          logo,
        ),
      ),
    );
  }
}
