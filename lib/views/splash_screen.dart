import 'package:bank/constants/colors.dart';
import 'package:bank/onBoarding/onboarding_page.dart';
import 'package:bank/views/features/home/home_page.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/images.dart';
import '../controllers/user_controller.dart';

class SplashScreen extends StatefulWidget {
  final bool user;
  const SplashScreen( {super.key, required this.user});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstSeen();
    check();
  }

  check() async {
    final userDataProvider =
        Provider.of<UserController>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await userDataProvider.userdatafetch(
        prefs.getString('nickName'), prefs.getString('pin'));
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      startSplashScreen();
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => const OnBoardingPage()));
    }
  }

  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  startSplashScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      if (prefs.getBool('user') == true) {
        Get.off(const HomePage());
      } else {
        Get.off(const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.background,
        body:  Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Image.asset(Images.loginbanner)),
                ),);
  }
}
