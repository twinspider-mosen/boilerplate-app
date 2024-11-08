import 'package:flutter/material.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/components/datePicker.dart';
import 'package:pos/controllers/Auth/authentication_controller.dart';
import 'package:pos/main.dart';
import 'package:pos/utility/constants.dart';
import 'package:get/get.dart';

class SecurityQuestion extends StatelessWidget {
  const SecurityQuestion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthenticationController(),
        builder: (cont) {
          return Scaffold(
            backgroundColor: colorManager.bgColor,
            appBar: AppBar(
              backgroundColor: colorManager.bgColor,
              scrolledUnderElevation: 0,
              elevation: 0,
              title: Text(
                "Account Security",
                style: TextStyle(color: colorManager.textColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Your Date of Birth",
                    style: TextStyle(
                        color: colorManager.primaryColor, fontSize: 18),
                  ),
                  Text(
                      "I case of account recovery, you have to answer this secuity question in order to proceed."),
                  SizedBox(
                    height: 12,
                  ),
                  DatePickerField(
                    dateController: cont.dateController,
                    label: "Date Of Birth",
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomButtom(
                      label: "Continue",
                      onTap: () {
                        prettyPrint({
                          'name': cont.nameController.text,
                          'email': cont.emailController.text,
                          'phone': cont.phoneController.text,
                          'pass': cont.passController.text
                        });
                        cont.udpateSecurity();
                      })
                ],
              ),
            ),
          );
        });
  }
}
