import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../views.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
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
    voice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.asset(logo)),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Select your langauge ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 32),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  var english = const Locale('en', 'IN');
                  Get.updateLocale(english);
                  TtsApi.api('selected language'.tr);
                  Get.off(LoginPage());
                },
                child: const Chip(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  label: Text('English'),
                  labelStyle: TextStyle(color: AppColor, fontSize: 26),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  var telugu = const Locale('te', 'IN');
                  Get.updateLocale(telugu);
                  TtsApi.api('selected language'.tr);
                  Get.off(LoginPage());
                },
                child: const Chip(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  label: Text('తెలుగు'),
                  labelStyle: TextStyle(color: AppColor, fontSize: 26),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          backgroundColor: backgroundColor,
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0))),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mic, color: AppColor, size: 26),
            5.width,
            Text('Tap to speak'.tr,
                style: primaryTextStyle(size: 16, color: AppColor))
          ],
        ),
        onPressed: () {
          Get.to(Mic(
            currentRoute: '/loginPage',
          ));
          // ExploreScreen().launch(context);
        },
      ).paddingOnly(bottom: 16),
    );
  }
}
