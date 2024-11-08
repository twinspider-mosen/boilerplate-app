import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/components/CustomButton.dart';
import 'package:pos/main.dart';
import 'package:pos/models/user_model.dart';
import 'package:pos/views/auth/login.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Unverified extends StatefulWidget {
  final String status, phone, shopName;
  Unverified(
      {super.key,
      required this.status,
      required this.phone,
      required this.shopName});

  @override
  State<Unverified> createState() => _UnverifiedState();
}

class _UnverifiedState extends State<Unverified> {
  late UserModel user;
  // getCurrentUSerDEtails

  @override
  Widget build(BuildContext context) {
    print(widget.status);
    return Scaffold(
        backgroundColor: colorManager.bgColor,
        body: Container(
          child: Center(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("App")
                      .where("screen", isEqualTo: widget.status)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: colorManager.primaryColor,
                      ));
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No Data Available'));
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.docs.first['title'],
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: colorManager.primaryColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 38.0, vertical: 4),
                          child: Text(
                            snapshot.data!.docs.first['description'],
                            style: TextStyle(fontSize: 16, letterSpacing: 1.2),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2),
                          child: CustomButtom(
                              label: 'Contact Now',
                              onTap: () async {
                                try {
                                  // if (widget.status == "pending_verification") {
                                  var actionUrl = snapshot
                                      .data!.docs.first['action']
                                      .toString()
                                      .replaceAll('phoneNumber', widget.phone)
                                      .replaceAll('shopName', widget.shopName);
                                  await launchUrl(Uri.parse(actionUrl));
                                  // }

                                  // await launchUrl(Uri.parse(
                                  //     snapshot.data!.docs.first['action']));
                                } catch (e) {
                                  EasyLoading.showToast(e.toString());
                                }
                                print(snapshot.data!.docs.first['action']);
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2),
                          child: CustomButtom(
                              textColr: colorManager.primaryColor,
                              backgroundColor:
                                  Color.fromARGB(255, 241, 241, 241),
                              label: 'Logout',
                              onTap: () async {
                                FirebaseAuth.instance.signOut().then((v) {
                                  Get.offAll(() => LoginScreen());
                                });
                              }),
                        )
                      ],
                    );
                  })),
        ));
  }
}
