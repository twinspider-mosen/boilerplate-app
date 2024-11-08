import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/components/customInput.dart';
import 'package:pos/controllers/Auth/authentication_controller.dart';
import 'package:pos/main.dart';
import 'package:pos/views/auth/forget_password.dart';
import 'package:pos/views/auth/register_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GetBuilder(
        init: AuthenticationController(),
        builder: (controller) {
          bool isAndroid = Platform.isAndroid;
          bool isIOS = Platform.isIOS;
          if (isAndroid) {
            print("Andoroid OS");
          }
          if (isIOS) {
            print("Apple  OS");
          }

          bool canRegister = isAndroid
              ? controller.canRegisterOnAndroid
              : isIOS
                  ? controller.canRegisterOnIOS
                  : true;
          return Scaffold(
            backgroundColor: colorManager.bgColor,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: SingleChildScrollView(
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
                        controller: controller.generalController,
                        prefixIcon: Icon(
                          Icons.person,
                          color: colorManager.primaryColor,
                        ),
                        hint: "Enter Email or Phone",
                      ),
                      CustomInput(
                        controller: controller.passController,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: colorManager.primaryColor,
                        ),
                        obsecure: controller.obscure,
                        hint: "Enter Password",
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
                      Container(
                        width: double.infinity,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                controller.clearControllers();

                                Get.to(() => ForgetPassword());
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: colorManager.primaryColor,
                                    letterSpacing: 1.3),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      CustomButtom(
                          label: "Login",
                          onTap: () {
                            // controller.checkUserCred();
                            controller.login();
                          }),
                      SizedBox(height: 10),

                      canRegister
                          ? Container()
                          : buildDividerWithText("Or Continue with"),

                      SizedBox(height: 10),

                      buildGoogleButton(() {
                        controller
                            .loginWithGoogle(controller.defaultMembership);
                      }),
                      SizedBox(
                        height: 40,
                      ),
                      buildRegisterPrompt(() {
                        // controller.clearControllers();
                        Get.offAll(() => RegisterScreen());
                      }),
                    ],
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
          // height: 40,
        ),
      ),
    );
  }
}

Widget buildDividerWithText(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 18.0),
    child: Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: colorManager.greyText,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            text,
            style: TextStyle(
              color: colorManager.primaryColor,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: colorManager.greyText,
          ),
        ),
      ],
    ),
  );
}

Widget buildGoogleButton(VoidCallback onPressed) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: colorManager.bgColor,
          border: Border.all(color: colorManager.primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "Continue With Google",
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 16,
              color: colorManager.primaryColor,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildRegisterPrompt(VoidCallback onPressed) {
  return RichText(
    text: TextSpan(
      text: "Don't have an Account? ",
      style: TextStyle(
        fontSize: 14,
        color: colorManager.textColor,
        letterSpacing: 1,
      ),
      children: [
        TextSpan(
          recognizer: TapGestureRecognizer()
            // ..onTap = () {
            //   controller.clearControllers();
            //   Get.offAll(() => RegisterScreen());
            // },
            ..onTap = onPressed,
          text: "Register",
          style: TextStyle(color: colorManager.primaryColor),
        ),
      ],
    ),
  );
}
