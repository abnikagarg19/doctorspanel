import 'dart:convert';

import 'package:chatbot/models/DoctorModelMeeting.dart';
import 'package:chatbot/service/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Doctorcontroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
   //getMeeting();
    // update();
    //print(parameters["pageIndex"]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DoctorModelMeeting> resposeList = [];
  bool isLoaded = false;
  void getMeeting() async {
    resposeList.clear();
    HomeService().apiGetMeeting().then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.body);
          if (decodedData["data"].isNotEmpty) {
            resposeList.add(DoctorModelMeeting.fromJson(decodedData));
          }

          update();
          break;
        case 401:
          Get.offAndToNamed("/login");
          //DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          break;
      }
    });
  }
}
