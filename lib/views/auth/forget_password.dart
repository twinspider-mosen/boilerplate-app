import 'package:flutter/material.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/components/customInput.dart';
import 'package:pos/components/datePicker.dart';
import 'package:pos/controllers/Auth/authentication_controller.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthenticationController(),
        builder: (cont) {
          return Scaffold(
            backgroundColor: colorManager.bgColor,
            appBar: AppBar(
              backgroundColor: colorManager.bgColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(
                'Forget Password',
                style: TextStyle(color: colorManager.primaryColor),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Enter your ",
                            style: TextStyle(
                                color: colorManager.textColor,
                                fontSize: 16,
                                letterSpacing: 1.2),
                            children: [
                          TextSpan(
                            text: "Email",
                            style: TextStyle(
                                color: colorManager.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: colorManager.textColor,
                            ),
                          ),
                          TextSpan(
                            text: "Phone number",
                            style: TextStyle(
                                color: colorManager.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " to verify your account. You will get an ",
                            style: TextStyle(
                              color: colorManager.textColor,
                            ),
                          ),
                          TextSpan(
                            text: "OTP",
                            style: TextStyle(
                                color: colorManager.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " on your ",
                            style: TextStyle(
                              color: colorManager.textColor,
                            ),
                          ),
                          TextSpan(
                            text: "Whatsapp",
                            style: TextStyle(
                                color: colorManager.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ". Enter that OTP here to create new password for your account. ",
                            style: TextStyle(
                              color: colorManager.textColor,
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: cont.forgetPassKey,
                      child: Column(
                        children: [
                          CustomInput(
                            isRequired: false,
                            hint: 'Enter Email',
                            controller: cont.emailController,
                          ),
                          CustomInput(
                            hint: 'Enter Phone Number',
                            controller: cont.phoneController,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          cont.isAccountValid
                              ? Container()
                              : CustomButtom(
                                  label: "Check",
                                  backgroundColor: Colors.grey.shade100,
                                  textColr: colorManager.primaryColor,
                                  onTap: () {
                                    if (cont.forgetPassKey.currentState!
                                        .validate()) {
                                      cont.checkAccountValidation();
                                    }
                                    // Get.to(OtpScreen());
                                  },
                                ),
                        ],
                      ),
                    ),
                    cont.isAccountValid
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Security Question',
                                style: TextStyle(
                                    color: colorManager.primaryColor,
                                    fontSize: 20),
                              ),
                              DatePickerField(
                                defaultValue: cont.currentData,
                                dateController: cont.dateController,
                                label: "Your Date of Birth",
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              CustomButtom(
                                label: "Verify",
                                // backgroundColor: Colors.grey.shade100,
                                // textColr: colorManager.primaryColor,
                                onTap: () {
                                  if (cont.forgetPassKey.currentState!
                                      .validate()) {
                                    cont.matchDOB();
                                  }
                                  print(cont.dateController.text);
                                  // Get.to(OtpScreen());
                                },
                              ),
                            ],
                          )
                        : Container(),
                    // cont.contactCustomerSupport
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: CustomButtom(
                          borderColor: Colors.transparent,
                          label: "Contact Customer Support",
                          onTap: () {
                            if (cont.forgetPassKey.currentState!.validate()) {
                              cont.forgetPassword();
                            }
                          }),
                    ), // : Container(),
                    cont.showOTPFields
                        ? Column(
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Enter OTP here',
                                style: TextStyle(
                                    color: colorManager.primaryColor,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(6, (index) {
                                  return SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      controller: cont.listControllers[index],
                                      cursorColor: colorManager.primaryColor,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      decoration: InputDecoration(
                                          hintText: "0",
                                          counterText: '',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: colorManager.borderColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colorManager
                                                      .primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: colorManager.borderColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colorManager
                                                      .primaryColor)),
                                          // label: Text("data"),
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade300),
                                          labelStyle: TextStyle(
                                              fontFamily: 'SF Pro',
                                              fontSize: 16,
                                              color: colorManager.primaryColor)),
                                      onChanged: (value) {
                                        if (value.length == 1 && index < 5) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              CustomButtom(
                                  label: "Verify",
                                  onTap: () {
                                    String otp = cont.listControllers
                                        .map((controller) => controller.text)
                                        .join();
                                    print('Entered OTP: $otp');
                                    cont.verifyOTP(otp);
                                  }),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
