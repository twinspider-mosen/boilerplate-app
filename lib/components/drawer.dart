import 'package:flutter/material.dart';
import 'package:pos/components/customSwitchButton.dart';
import 'package:pos/controllers/dashboard/drawerController.dart';
import 'package:pos/main.dart';
import 'package:pos/views/settings/appSettings.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrarController>(
        init: DrarController(),
        builder: (cont) {
          return Drawer(
            backgroundColor: colorManager.bgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 72,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Image.asset(
                    'assets/imgs/logo.png',
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: colorManager.primaryColor,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),

                          ListTile(
                            leading: Icon(
                              Icons.currency_exchange_outlined,
                              color: colorManager
                                  .primaryColor, // Replace with your  colorManager.primaryColor
                            ),
                            title: Text(
                              "Currency",
                              style: TextStyle(
                                color: colorManager.textColor,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 70,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor:
                                      colorManager.bgColor.withOpacity(0.3),
                                  elevation: 1,
                                  menuWidth: 60,
                                  hint: Text(
                                    cont.currency ?? 'Rs',
                                    style: TextStyle(
                                      color: colorManager.textColor,
                                    ),
                                  ),
                                  value: cont.currency,
                                  onChanged: (String? newValue) {
                                    cont.updateCurrency(newValue);
                                  },
                                  items: cont.dropdownItems
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: colorManager.textColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          /////////////////////

                          cont.canDelete == true
                              ? ListTile(
                                  onTap: () {
                                    // cont.logout();
                                    cont.showConfirmationDialog(context);
                                  },
                                  leading: Icon(
                                    (Icons.delete),
                                    color: colorManager.primaryColor,
                                  ),
                                  title: Text(
                                    "Delete Acoount",
                                    style: TextStyle(
                                      color: colorManager.textColor,
                                    ),
                                  ),
                                )
                              : Container(),

                          ListTile(
                            onTap: () {
                              // cont.logout();
                              launchUrl(
                                  Uri.parse('https://twinspider.com/contact/'));
                            },
                            leading: Icon(
                              (Icons.help),
                              color: colorManager.primaryColor,
                            ),
                            title: Text(
                              "Help",
                              style: TextStyle(
                                color: colorManager.textColor,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => AppSettings());
                            },
                            leading: Icon(
                              (Icons.settings),
                              color: colorManager.primaryColor,
                            ),
                            title: Text(
                              "Settings",
                              style: TextStyle(
                                color: colorManager.textColor,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              cont.logout();
                            },
                            leading: Icon(
                              (Icons.logout),
                              color: colorManager.primaryColor,
                            ),
                            title: Text(
                              "Logout",
                              style: TextStyle(
                                color: colorManager.textColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
