import 'package:bank/services/services.dart';
import 'package:bank/utils/utils.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  permission() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      Permission.microphone.request();
    } else if (status.isGranted) {
    } else if (status.isPermanentlyDenied) {
      Permission.microphone.request();
    } else if (status.isRestricted) {}
  }

  voice() async {
    await TtsApi.api("please Select your langauge");
    await TtsApi.api("దయచేసి మీ భాషను ఎంచుకోండి");
  }

  @override
  void initState() {
    super.initState();
    permission();
  }

  final introKey = GlobalKey<IntroductionScreenState>();
  bool selected = false;
  int index = 0;
  void _onIntroEnd(context) {
    Get.off( LoginPage());
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0,),
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 0,
    
        pages: [
          PageViewModel(
            titleWidget: const Column(
              children: [
                Text(
                  "Select your langauge",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(" మీ భాషను ఎంచుకోండి", style: TextStyle(fontSize: 24))
              ],
            ),
            bodyWidget: Column(
              children: [
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      selected = true;
                      index = 1;
                    });
                    var english = const Locale('en', 'US');
                    Get.updateLocale(english);
                    prefs.setString('language', 'en');
                    //  prefs.setString('country', 'IN');
                    TtsApi.api('selected language'.tr);
                    //  Get.off(const LoginPage());
                  },
                  child: Chip(
                    avatar: (index == 1 && selected == true)
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                    backgroundColor: AppColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    label: const Text('English'),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontSize: 26),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      selected = true;
                      index = 2;
                    });
                    var telugu = const Locale('te', 'IN');
                    Get.updateLocale(telugu);
                    prefs.setString('language', 'te');
                    //  prefs.setString('country', 'IN');
                    TtsApi.api('selected language'.tr);
                    // Get.off(const LoginPage());
                  },
                  child: Chip(
                    avatar: (index == 2 && selected == true)
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                    backgroundColor: AppColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    label: const Text('తెలుగు'),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontSize: 26),
                  ),
                ),
              ],
            ),
            image: _buildImage('assets/images/lan.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            //  useScrollView: true,
            title: "How to use".tr,
            bodyWidget: Column(
              children: [
                RichText(
                    text: TextSpan(
                  children: [
                     TextSpan(
                       text: '${'Step'.tr} 1 :',
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    TextSpan(
                      text: 'des1'.tr,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    )
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                     TextSpan(
                        text: '${'Step'.tr} 2 :',
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    TextSpan(
                      text: 'des2'.tr,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    )
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                     TextSpan(
                        text: '${'Step'.tr} 3 :',
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    TextSpan(
                      text: 'des3'.tr,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    )
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                     TextSpan(
                        text: '${'Step'.tr} 4 :',
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    TextSpan(
                      text: 'des4'.tr,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    )
                  ],
                )),
              ],
            ),
            image: _buildImage('assets/images/1.jpeg'),
            decoration: pageDecoration.copyWith(
              bodyFlex: 6,
              imageFlex: 4,
              safeArea: 10,
            ),
          ),
          PageViewModel(
            title: "Commands Guide".tr,
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To go to home page'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'To go to profile page'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'To check balance'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'To see histoy'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'To send money'.tr,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
            decoration: pageDecoration.copyWith(
              bodyFlex: 6,
              imageFlex: 4,
             
              bodyAlignment: Alignment.topCenter,
              imageAlignment: Alignment.topCenter,
            ),
            image: _buildImage('assets/images/guide.png'),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
    
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: true,
        //rtl: true, // Display as right-to-left
        back: const Icon(
          Icons.arrow_back,
          size: 32,
        ),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: (selected)
            ? const Icon(Icons.arrow_forward, size: 32)
            : const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 0,
              ),
        done: Text('Login'.tr,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeColor: AppColor,
          activeShape: RoundedRectangleBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
