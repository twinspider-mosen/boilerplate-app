import 'package:flutter/material.dart';
import 'package:pos/components/add_data_form.dart';
import 'package:pos/controllers/dashboard/dashboardController.dart';
import 'package:pos/views/auth/login.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Dashboardcontroller(),
        builder: (cont) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Dashboard"),
              actions: [
                GestureDetector(
                    onTap: () {
                      cont.auth.signOut().then((v) {
                        Get.offAll(() => LoginScreen());
                      });
                    },
                    child: Icon(Icons.logout))
              ],
            ),
            body: Column(
              children: [AddDataForm(), Expanded(child: DataList())],
            ),
          );
        });
  }
}
