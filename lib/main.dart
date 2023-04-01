import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/history_controller.dart';
import 'package:bank/controllers/textFieldController/textfield_controller.dart.dart';
import 'package:bank/controllers/mic_controller.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/services/network_services.dart';
import 'package:bank/views/features/languagePage/language.dart';
import 'package:bank/views/features/home/home.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:bank/views/features/profile/profile_page.dart';
import 'package:bank/views/features/send/send_page.dart';
import 'package:bank/views/splash_screen.dart';
import 'package:bank/views/views.dart';
import 'package:bank/views/widgets/demo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import 'localStrings/localStrings.dart.dart';
import 'onBoarding/onboarding_page.dart';
import 'views/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  late String nickName;
  late String pin;
  bool user = false;
  String language = '';
  // String country = 'IN';
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    checkonboardingCompleted();
  }

  checkonboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
     setState(() {
      language = prefs.getString('language') ?? 'en';
      //  country = prefs.getString('country') ?? 'IN';
      
    });
    if (onboardingCompleted) {
      const OnBoardingPage();
      prefs.setBool('onboardingCompleted', true);
    } else {
      checkLoginStatus();
    }
  }

  checkLoginStatus() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    nickName = prefs.getString('nickName') ?? '';
    pin = prefs.getString('pin') ?? '';
    if (nickName != null && pin != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }






  @override
  Widget build(BuildContext context) {
    // SpeechController.listen('Hello how can i help you');
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MicController>(create: (_) => MicController()),
          ChangeNotifierProvider<UserController>(
              create: (context) => UserController()),
          ChangeNotifierProvider<TextFieldController>(
              create: (context) => TextFieldController()),
        ],
        child: GetMaterialApp(
            translations: LocalString(),
            locale: Locale(language, 'IN'),
            builder: (context, child) {
              return ScrollConfiguration(
                  behavior: MyBehaviour(), child: child!);
            },
            title: 'Smart Bank',
            debugShowCheckedModeBanner: false,
            transitionDuration: const Duration(milliseconds: 300),
            defaultTransition: Transition.cupertino,
            theme: ThemeData(
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.red),
              primarySwatch: Colors.blue,
            ),
            getPages: [
              GetPage(
                name: '/languagePage',
                page: () => const LanguagePage(),
              ),
              GetPage(
                name: '/homePage',
                page: () => HomePage(),
              ),
              GetPage(
                name: '/profilePage',
                page: () => ProfilePage(),
              ),
              GetPage(
                name: '/sendPage',
                page: () => const SendPage(),
              ),
              GetPage(
                name: '/loginPage',
                page: () => const LoginPage(),
              ),
              GetPage(
                name: '/registerPage',
                page: () => const SignUpPage(),
              ),
              GetPage(
                name: '/setPinPage',
                page: () => PinSetUp(
                  fullName: '',
                  mobileNumber: '',
                  nickNmae: '',
                  userName: '',
                ),
              ),
              GetPage(
                name: '/recordPage',
                page: () => const RecordPage(),
              ),
            ],
            home: OnBoardingPage()));
  }
}

class MyBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
