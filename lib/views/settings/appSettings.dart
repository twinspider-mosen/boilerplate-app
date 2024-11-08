import 'package:flutter/material.dart';
import 'package:pos/components/customSwitchButton.dart';
import 'package:pos/main.dart';
import 'package:get/get.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorManager.bgColor,
      appBar: AppBar(
        backgroundColor: colorManager.bgColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          "App Settings",
          style: TextStyle(color: colorManager.textColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Theme (${colorManager.isDark ? "Dark" : "Light"} Mode)",
                  style: TextStyle(color: colorManager.textColor, fontSize: 18),
                ),
                CustomSwitch(
                  inactiveIcon: Icon(
                    Icons.dark_mode,
                    size: 16,
                    color: colorManager.primaryColor,
                  ),
                  activeIcon: Icon(
                    Icons.light_mode,
                    size: 16,
                    color: colorManager.primaryColor,
                  ),
                  value: colorManager.isDark,
                  onChanged: (newVal) {
                    // colorManager.isDark = newVal;
                    colorManager.toggleTheme(newVal);

                    setState(() {});
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
