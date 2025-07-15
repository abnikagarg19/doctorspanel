import 'dart:convert';

import 'package:chatbot/service/auth_service.dart';
import 'package:chatbot/view/home.dart';
import 'package:chatbot/view/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/commons.dart';
import '../service/shared_pref.dart';
import '../utils/app_routes.dart';

class SignUpController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final pinController = TextEditingController();
  List onBoard = [
    "1. Personal & Contact Information",
    "2. Professional Credentials",
    "3. Experience & Specialization"
  ];
  bool isRemember = false;
  var passwordLoginVisibility = false;
  void showPassword() {
    passwordLoginVisibility = !passwordLoginVisibility;
    update();
  }

  var passwordLoginVisibility2 = false;
  void showPassword2() {
    passwordLoginVisibility2 = !passwordLoginVisibility2;
    update();
  }

  final service = AuthService();
  int selectedIndex = 0;
  onChangeIndex(index) {
    selectedIndex = index;
    update();
  }

  signUp() {
    DialogHelper.showLoading();
    service.apiSignUpService(email.text, password.text).then((value) {
      print(value.statusCode);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.body);
          if (data2["status"].toString() == "1") {
            DialogHelper.showErroDialog(
                description: "Please verify your email");
            Get.to(OtpPage(emailid: data2["id"].toString(), email: email.text));
          } else if (data2["status"].toString() == "2") {
            DialogHelper.showErroDialog(
                description: "Already registered please login");
          } else {
            Get.to(OtpPage(
                emailid: data2["email_id"].toString(), email: email.text));
          }

          break;
        case 400:
          var data2 = jsonDecode(value.body);
          DialogHelper.showErroDialog(description: data2["detail"].toString());

          break;
        case 1:
          break;
        default:
          DialogHelper.showErroDialog(description: "Try again later");
          break;
      }
    });
  }

  void verifyOtp(String otp, emailid) async {
    DialogHelper.showLoading();
    service.apiVerifyOtpService(otp, emailid).then((value) {
      print(value.body);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          var data2 = jsonDecode(value.body);

          PreferenceUtils.setString("email", data2["email"].toString());
          PreferenceUtils.setString("id", data2["id"].toString());
          PreferenceUtils.setString("name", data2["name"].toString());
          PreferenceUtils.saveUserToken(data2["token"].toString());
          //  Get.offAll(AiChatBot());
          // // Get.toNamed(Routes.CREATEMENEMID);

          break;
        case 400:
          var data2 = jsonDecode(value.body);
          DialogHelper.showErroDialog(description: data2["detail"].toString());

          break;
        case 1:
          break;
        default:
          DialogHelper.showErroDialog(description: "Try again later");
          break;
      }
    });
  }

  void otpResendValidSubmit(String email) async {
    DialogHelper.showLoading();
    service.apiResendOtp(email).then((value) {
      print(value.statusCode);
      DialogHelper.hideLoading();
      switch (value.statusCode) {
        case 200:
          pinController.text = "";
          DialogHelper.showErroDialog(description: "Resend Successfully");
          break;
        case 400:
          var data2 = jsonDecode(value.body);
          DialogHelper.showErroDialog(description: data2["detail"].toString());

          break;
        case 1:
          break;
        default:
          DialogHelper.showErroDialog(description: "Try again later");
          break;
      }
    });
  }
}
