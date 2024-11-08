import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/components/customInput.dart';
import 'package:pos/controllers/Auth/authentication_controller.dart';
import 'package:pos/main.dart';
import 'package:pos/views/auth/login.dart';
import 'package:get/get.dart';

class PhoneRegistration extends StatelessWidget {
  PhoneRegistration({super.key});

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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/imgs/logo.png',
                          height: 150,
                        ),
                        // SizedBox(
                        //   height: height * 0.08,
                        // ),
                        SizedBox(height: 20),

                        CustomInput(
                          controller: controller.nameController,
                          prefixIcon: Icon(
                            Icons.person,
                            color: colorManager.primaryColor,
                          ),
                          hint: "Enter Name",
                        ),
                        CustomInput(
                          controller: controller.emailController,
                          prefixIcon: Icon(
                            Icons.email,
                            color: colorManager.primaryColor,
                          ),
                          hint: "Enter Phone",
                        ),
                        CustomInput(
                          controller: controller.emailController,
                          prefixIcon: Icon(
                            Icons.email,
                            color: colorManager.primaryColor,
                          ),
                          hint: "Confirm Phone",
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
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                            label: "Create Account",
                            onTap: () {
                              // controller.createAccountWithPhone();
                            }),

                        SizedBox(
                          height: 12,
                        ),
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
                        SizedBox(
                          height: 18,
                        ),
                      ]),
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
