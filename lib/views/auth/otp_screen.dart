import 'package:flutter/material.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/main.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _controllers[index],
                    cursorColor: colorManager.primaryColor,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorManager.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(16)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colorManager.primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorManager.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colorManager.primaryColor)),
                        // label: Text("data"),
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
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "Enter",
                    style: TextStyle(
                        color: colorManager.textColor,
                        fontSize: 16,
                        letterSpacing: 1.2),
                    children: [
                      TextSpan(
                        text: " OTP ",
                        style: TextStyle(color: colorManager.primaryColor),
                      ),
                      TextSpan(
                        text: "from",
                        style: TextStyle(
                          color: colorManager.textColor,
                        ),
                      ),
                      TextSpan(
                        text: " Whatsapp",
                        style: TextStyle(color: colorManager.primaryColor),
                      ),
                      TextSpan(
                        text: " to create new password for your account. ",
                        style: TextStyle(
                          color: colorManager.textColor,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 10),
            CustomButtom(
              onTap: () {
                String otp =
                    _controllers.map((controller) => controller.text).join();
                print('Entered OTP: $otp');
                // Add your OTP verification logic here
              },
              label: "Verify OTP",
            ),
          ],
        ),
      ),
    );
  }
}
