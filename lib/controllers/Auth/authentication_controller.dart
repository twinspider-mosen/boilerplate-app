import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos/models/user_model.dart';
import 'package:pos/utility/constants.dart';
import 'package:pos/views/auth/create_new_password.dart';
import 'package:pos/views/auth/login.dart';
import 'package:pos/views/dashboard/dashbaord.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthenticationController extends GetxController {
  String userRole = "";

  SharedPreferences? prefs;
  bool obscure = true;
  final registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final confirmController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final generalController = TextEditingController();

  final GlobalKey<FormState> newPassKey = GlobalKey<FormState>();

  showPass() {
    obscure = !obscure;
    update();
  }

  bool isAccountValid = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance.collection("Users");
  final settingsDb = FirebaseFirestore.instance.collection("App");

  loginWithPhoneNumber() async {
    try {
      QuerySnapshot querySnapshot =
          await db.where('email', isEqualTo: emailController.text).get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        if (userDoc['pass'] == passController.text) {
          // Get.offAll(() => RoleScreen());
        } else {
          EasyLoading.showError("Invalid password");
        }
      } else {
        EasyLoading.showError("Invalid Phone");
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError("Something went wrong!");
    }
  }

  checkUserCred(String input) {
    if (isEmail(input)) {
      return "email";
    } else if (isPhoneNumber(input)) {
      return "phone";
    } else {
      return "";
    }
  }

/////
/////////////////////////////////////////////

  void createAccount() {
    createAccountWithEmail(
            emailController.text, passController.text)
        .then((v) {
      
    }).onError((e, s) {
      EasyLoading.showError("Invalid Credentials!");
    });
  }
  
  // void createAccount() {
  //   createAccountWithEmail(
  //           convertToEmail(phoneController.text), passController.text)
  //       .then((v) {
  //     createUserDocument();
  //   }).onError((e, s) {
  //     EasyLoading.showError("Invalid Credentials!");
  //   });
  // }


  clearControllers() {
    userCurrentRole = 'shop';
    nameController.clear();
    confirmController.clear();
    emailController.clear();
    generalController.clear();
    phoneController.clear();
    passController.clear();
    dateController.clear();
    listControllers.map((e) => e.clear());
    update();
  }

  String convertToEmail(String phone) {
    if (isPhoneNumber(phone)) {
      return phone + "@boilerplate.com";
    } else {
      return "invalid phone";
    }
  }

  UserModel? user;
login()async{
  try{
    EasyLoading.show(status: "Signing in...");
    signIn(emailController.text, passController.text);
  }catch(e){
     print("Error: $e");
        EasyLoading.showError("Something went wrong!");
  }
}

  // login() async {
  //   String inputType = checkUserCred(generalController.text);
  //   if (inputType == 'email') {
  //     try {
  //       QuerySnapshot querySnapshot =
  //           await db.where("email", isEqualTo: generalController.text).get();

  //       if (querySnapshot.docs.isNotEmpty) {
  //         var data = querySnapshot.docs.first;
  //         var email = convertToEmail(data['phone']);

  //         signIn(email, passController.text);
  //       } else {
  //         print('No account found with the provided email.');
  //         EasyLoading.showInfo('No account found with the provided email.');
  //       }
  //     } catch (e) {
  //       print("Error: $e");
  //       EasyLoading.showError("Something went wrong!");
  //     }
  //   } else {
  //     var email = convertToEmail(generalController.text);
  //     signIn(email, passController.text);
  //   }
  // }

  String defaultMembership = "";
  getDefaultMembershipStatus1() async {
    try {
      QuerySnapshot querySnapshot = await settingsDb
          .where("screen", isEqualTo: 'defaul_membership_status')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs.first;
        defaultMembership = data['status'];
        print(defaultMembership);
        update();
      } else {
        defaultMembership = "expired";
        print(defaultMembership);
        update();

        EasyLoading.showInfo(
            'No screen found with the value:default_membership_status');
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError("Something went wrong!");
    }
  }

  signIn(email, pass) async {
    print(email);
    try {
      EasyLoading.show(status: "Signing in...");
      await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      clearControllers();

      update();
      Get.offAll(() => Dashboard());
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError("Incorrect credentials!");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future getUserDetails(String uID) async {
    var res = await db.doc(uID).get();
    user = UserModel.fromFirestore(res);
    update();
  }

  loginWithGoogle(default_membership) async {
    try {
      EasyLoading.show(status: "Signing in...");
      await signInWithGoogle().then((value) async {
        EasyLoading.dismiss();
        print(value.user!.displayName);
        Get.offAll(Dashboard());
      });
    } catch (e) {
      print("Error : $e");
      EasyLoading.showError("Something went wrong!");
    }
  }

  updateUserRole(String role) {
    userRole = role;
    update();
  }

  Future<void> setUserPreferences(String shopId) async {
    prefs!.setString("id", shopId);
    prefs!.setString("role", "employee");
  }

  udpateUserRoleOnFirebase(id, role) async {
    await db.doc(id).update({
      'role': role,
    });
  }

  udpateSecurity() async {
    await db
        .doc(auth.currentUser!.uid)
        .update({'dob': dateController.text}).then((v) {
      EasyLoading.showToast("Account Security updated");
      // navigate == false ? null : Get.offAll(Dashboard());
    });
  }

  Future<void> createUserDocument() async {
    await db.doc(auth.currentUser!.uid.toString()).set({
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "pass": passController.text,
      "image": auth.currentUser!.photoURL ?? "",
      "dob": "",
      "address": "",
    });
  }

  createGoogleUserProfile(String role, default_membership) async {
    await db.doc(auth.currentUser!.uid.toString()).set({
      "name": auth.currentUser!.displayName,
      "email": auth.currentUser!.email,
      "phone": auth.currentUser!.phoneNumber ?? "0333 XXXXXXX",
      "image": auth.currentUser!.photoURL ?? "",
      "address": "",
      "dob": "",
      'pass': passController.text ?? "",
      "order_count": "0",
      "role": role,
    }).then((val) {
      EasyLoading.dismiss();
      prefs!.setString("id", auth.currentUser!.uid);
      prefs!.setString("role", role);
      Get.offAll(() => Dashboard());
      clearControllers();
    });
  }

  Future createAccountWithEmail(email, pass) async {
    try {
      EasyLoading.show(status: "Creating Account...");
      await auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((v) {
            createUserDocument().then((val){
 Get.offAll(Dashboard());
            });
       
        EasyLoading.dismiss();
      });
    } catch (e) {
      print(e);
      if (e.toString().contains("email address is already")) {
        EasyLoading.showError("Email Already Exist!");
      } else {
        EasyLoading.showError("Something went wrong.");
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  initSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future logout() async {
    EasyLoading.show(status: "Signing out...");
    await auth.signOut().then((v) {
      EasyLoading.dismiss();
      Get.offAll(() => LoginScreen());
    });
  }

  // Apple Authentication
  String generateNonce([int length = 32]) {
    String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  bool canRegister = false;
  bool canRegisterOnAndroid = false;
  bool canRegisterOnIOS = false;
  String forgetPassUrl = "";
  bool canForget = false;

  Future checkAppSettings() async {
    await FirebaseFirestore.instance
        .collection("App")
        .where('screen', isEqualTo: 'login')
        .get()
        .then((v) {
      canRegister = v.docs.first['can_register'];
      canRegisterOnAndroid = v.docs.first['can_register_on_android'];
      canRegisterOnIOS = v.docs.first['can_register_on_ios'];
      update();
    });
    await FirebaseFirestore.instance
        .collection("App")
        .where('screen', isEqualTo: 'forget_pass')
        .get()
        .then((v) {
      canForget = v.docs.first['can_forget'];
      forgetPassUrl = v.docs.first['action'];
      update();
    });
  }

  String userCurrentRole = "shop";
  setUserRole(value) {
    if (value) {
      userCurrentRole = 'shop';
      update();
    } else {
      userCurrentRole = 'employee';
      update();
    }
    print("User role: $userCurrentRole");
  }

// forget password
  final GlobalKey<FormState> forgetPassKey = GlobalKey<FormState>();

  List<TextEditingController> listControllers =
      List.generate(6, (_) => TextEditingController());

  Future forgetPassword() async {
    var actionUrl = forgetPassUrl
        .replaceAll('phoneNumber', phoneController.text)
        .replaceAll('emailAddress', emailController.text);
    await launchUrl(Uri.parse(actionUrl)).then((v) {
      contactCustomerSupport = false;
      showOTPFields = true;
      update();
    });
  }

  Future<void> verifyOTP(String otp) async {
    try {
      EasyLoading.show(status: "Verifying...");

      final querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where("email", isEqualTo: emailController.text)
          .where("phone", isEqualTo: phoneController.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        final verificationCode = doc['otp'];
        var pass = doc['pass'];
        var decryptedPass = print("Your otp " + otp);
        print("Your verificaiton code " + verificationCode.toString());

        if (otp == verificationCode.toString()) {
          var email = convertToEmail(phoneController.text);
          auth
              .signInWithEmailAndPassword(email: email, password: pass)
              .then((v) {
            Get.offAll(() => CreateNewPassword());
          });
        } else {
          EasyLoading.showToast("Enter correct OTP!");
        }
      } else {
        EasyLoading.showToast(
            "No user found with the provided email and phone!");
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError("Something went wrong!");
    } finally {
      EasyLoading.dismiss();
    }
  }

  updateUserRoleOnSharedPrefs(String role) async {
    await SharedPreferences.getInstance().then((val) {
      val.setString("role", role);
      val.setString('id', auth.currentUser!.uid);
      update();
    });
  }

  Future updateUserPass(String pass) async {
    try {
      EasyLoading.show(status: "Loading...");
      await auth.currentUser!.updatePassword(pass).then((v) {
        db.doc(auth.currentUser!.uid).update({'pass': pass}).then((va) {
          clearControllers();
          EasyLoading.showSuccess("Password updated successfully!");
          udpateUserRoleOnFirebase(auth.currentUser!.uid, 'shop');
          updateUserRoleOnSharedPrefs('shop');

          update();
          Get.offAll(Dashboard());
        });
      });
    } catch (e) {
      print("Error : $e");
      EasyLoading.showError("Something went wrong!");
    }
  }

  var userDOB = "";
  Future<void> checkAccountValidation() async {
    EasyLoading.show(status: "Checking...");

    final querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: emailController.text)
        .where("phone", isEqualTo: phoneController.text)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      EasyLoading.dismiss();
      final doc = querySnapshot.docs.first;
      isAccountValid = true;
      update();
    } else {
      contactCustomerSupport = true;
      update();
      EasyLoading.showToast('No User Found!');
    }
  }

  bool contactCustomerSupport = false;
  bool showOTPFields = false;
  final dateController = TextEditingController();
  String currentData = DateFormat('dd-MM-yyyy').format(DateTime.now());
  matchDOB() async {
    try {
      EasyLoading.show(status: "Verifying...");

      final querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where("email", isEqualTo: emailController.text)
          .where("dob", isEqualTo: dateController.text)
          .where("phone", isEqualTo: phoneController.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        var pass = doc['pass'];

        var email = convertToEmail(phoneController.text);
        auth.signInWithEmailAndPassword(email: email, password: pass).then((v) {
          clearField();
          clearControllers();
          Get.offAll(() => CreateNewPassword());
        });
      } else {
        EasyLoading.showToast("Enter correct Date of Birth");
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError("Something went wrong!");
    } finally {
      EasyLoading.dismiss();
    }
  }

  clearField() {
    isAccountValid = false;
    showOTPFields = false;
    contactCustomerSupport = false;
    update();
  }

  @override
  void onInit() {
    // checkAppSettings();
    // getDefaultMembershipStatus();
    initSP();
    super.onInit();
  }
}
