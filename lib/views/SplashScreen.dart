
import 'dart:async';

import 'package:bank/controllers/user_controller.dart';
import 'package:bank/views/features/onBoarding/onboarding_page.dart';
import 'package:bank/utils/Colors.dart';
import 'package:bank/views/widgets/PinVerifyScreen.dart';
import 'package:bank/views/features/home/main_screen.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
   final bool user;
    const SplashScreen( {super.key, required this.user});
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  void initState() {
    super.initState();
    checkFirstSeen();
    check();
     getConnectivity();
     
  }


  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });
  // init() async {
  //   await Future.delayed(const Duration(seconds: 2));

  //   finish(context);
  //   //setStatusBarColor(backgroundColor, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark);

  //   //  MainScreen().launch(context);
  // }
  
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      startSplashScreen();
    } else {
      await prefs.setBool('seen', true);
      Get.off(const OnBoardingPage());
      
    }
  }
    check() async {
    final userDataProvider =
        Provider.of<UserController>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await userDataProvider.userdatafetch(
        prefs.getString('nickName'), 
        prefs.getString('pin'));
  }
   void afterFirstLayout(BuildContext context) => checkFirstSeen();

  startSplashScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      if (prefs.getBool('user') == true) {
        
        Get.off( PinVerifyScreen(auth: false,));
      } else {
        Get.off( LoginPage());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.jpg',),
            50.height
          ],
        ),
      ),
    );
  }

   showDialogBox() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('No Connection'),
            content: const Text('Please check your internet connection'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    setState(() => isAlertSet = false);
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(() => isAlertSet = true);
                    }
                  },
                  child: const Text('ok'))
            ],
          ));
}
