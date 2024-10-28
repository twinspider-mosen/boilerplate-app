import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//  Color  colorManager.primaryColor = Color.fromARGB(255, 219, 127, 34);
//  Color  colorManager.primaryColor = Color(0xffD99754);
//  Color  colorManager.primaryColor = Color(0xff161616);
//  Color  colorManager.primaryColor = Color(0xffE94057);

// const Color secondaryColor = Color.fromARGB(114, 233, 64, 87);

prettyPrint(mapData) {
  var data = JsonEncoder.withIndent('  ').convert(mapData);
  print(data);
}

String androidAppId = "com.twinspider.darzi_app";
String iosAppId = "6720752754";

bool isEmail(String input) {
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(input);
}

bool isPhoneNumber(String input) {
  final phoneRegex = kDebugMode ? RegExp(r'^\d{4,14}$') : RegExp(r'^\d{9,14}$');
  return phoneRegex.hasMatch(input);
}

String capitalize(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

// String encryptPassword(String password) {
//   final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
//   final bytes = utf8.encode(hashedPassword);
//   final base64Encoded = base64.encode(bytes);
//   return base64Encoded;
// }

String capitalizeFullName(String fullName) {
  if (fullName.isEmpty) {
    return fullName;
  }
  List<String> nameParts = fullName.split(' ');
  List<String> capitalizedParts = nameParts.map((name) {
    if (name.isEmpty) {
      return name;
    }
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }).toList();
  return capitalizedParts.join(' ');
}

// // Customer > customerId >
//   Map<String, dynamic> customerformResponse = {
//     "shop_id": "Darzi ID",
//     'name': "NAme",
//     "phoen": "Phomne",
//     "address": "Address"
//   };
// // Sizing > randomDocID >
//   Map<String, dynamic> sizingformResponse = {
//     "shop_id": "Darzi ID",
//     "customer_id": "Customer ID",
//     'item 1': {"attr1": "value", "attr2": "value", "attr3": "value"},
//     'item 2': {"attr1": "value", "attr2": "value", "attr3": "value"},
//     'item 3': {"attr1": "value", "attr2": "value", "attr3": "value"},
//   };