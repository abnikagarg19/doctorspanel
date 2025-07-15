import 'package:chatbot/bindings.dart/init.dart';
import 'package:chatbot/bindings.dart/loginBindings.dart';
import 'package:chatbot/videocall/join_screen.dart';
import 'package:chatbot/view/home.dart';
import 'package:chatbot/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings.dart/signupBindings.dart';
import '../view/signup.dart';
import '../view/splash.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SIGNUP = _Paths.SIGNUP;
  static const SPLASHSCREEN = _Paths.SPLASHSCREEN;
  static const LOGIN = _Paths.LOGIN;
  static const Task = _Paths.Task;
  static const journal = _Paths.journal;
   static const onBoarding = _Paths.onBoarding;
    static const promodoro = _Paths.promodoro;
    static const videocall = _Paths.videocall;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SPLASHSCREEN = '/';
  static const LOGIN = '/login';
  static const SIGNUP = '/sigup';
  static const Task = '/task';
  static const journal = '/journal';
    static const promodoro = '/promodoro';
  static const onBoarding = '/on_board';
    static const videocall = '/videocall';
}

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
        name: AppPages.INITIAL,
        page: () {
          return const SplashScreen();
        },
        binding: InitBindings()),
  
    GetPage(
        name: Routes.LOGIN,
        page: () {
          return Login();
        },
        binding: LoginBindings()),
    GetPage(
        name: _Paths.SIGNUP,
        page: () => SignUpPage(),
        binding: SignupBindings()),
         GetPage(
        name: _Paths.videocall,
        page: () => DoctorJoinScreen(),
       ),
  ];
}
