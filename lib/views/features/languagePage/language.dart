import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import '../../views.dart';
import '../../widgets/widgets.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
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
    await SpeechController.listen("please Select your langauge");
    await SpeechController.listen("దయచేసి మీ భాషను ఎంచుకోండి");
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
      backgroundColor: ThemeColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.asset(Images.loginbanner)),
              ),
              const SizedBox(height: 50,),
              const Text(
                'Select your langauge',
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
                  var english = const Locale('en', 'US');
                  Get.updateLocale(english);
                  SpeechController.listen('selected language'.tr);
                  Get.off(const LoginPage());
                },
                child: const Chip(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  label: Text('English'),
                  labelStyle:
                      TextStyle(color: ThemeColors.background, fontSize: 26),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  var telugu = const Locale('te', 'IN');
                  Get.updateLocale(telugu);
                  SpeechController.listen('selected language'.tr);
                  Get.off(const LoginPage());
                },
                child: const Chip(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  label: Text('తెలుగు'),
                  labelStyle:
                      TextStyle(color: ThemeColors.background, fontSize: 26),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Mic(),
    );
  }
}
