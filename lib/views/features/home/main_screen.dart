import 'dart:async';

import 'package:bank/utils/Colors.dart';
import 'package:bank/views/features/home/home_screen.dart';
import 'package:bank/views/features/qr/qrScannerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controllers.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});
  
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  PageController? controller;
  int currentPage = 0;
  late DateTime currentBackPressTime;
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    super.initState();
    init();
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

  init() async {
    controller = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    controller?.dispose();
    subscription.cancel();
    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit App',
              style: TextStyle(color: Colors.black),
            ),
            content: const Text(
              'Do you want to exit an App?',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColor),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColor),
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserController>(context);
    userDataProvider.history;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: PageView(
          reverse: false,
          pageSnapping: true,
          onPageChanged: (index) {
            currentPage = index;
          },
          children: [
            const HomeScreen(),
            QrScannerScreen(),
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
