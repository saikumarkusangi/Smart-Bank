import 'dart:math';

import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/telugu_data_controller.dart';
import 'package:bank/utils/utils.dart';
import 'package:bank/views/features/send/amount_Screen.dart';
import 'package:bank/views/features/send/to_person.dart';
import 'package:bank/views/views.dart';
import 'package:bank/views/widgets/demo.dart';
import 'package:bank/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localStrings/localStrings.dart.dart';
import 'package:quick_actions/quick_actions.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
  bool appTheme = false;
  // String country = 'IN';
  @override
  void initState() {
    super.initState();
    quickActions();
    checkLoginStatus();
    checkonboardingCompleted();
  }

  quickActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'Scan & pay',
        localizedTitle: 'Scan & pay',
        icon: 'scan',
      ),
      const ShortcutItem(
          type: 'Send Money', localizedTitle: 'Send Money', icon: 'send'),
      const ShortcutItem(
          type: 'Tap to Speak', localizedTitle: 'Tap to Speak', icon: 'mic'),
      const ShortcutItem(
          type: 'Show History',
          localizedTitle: 'Show History',
          icon: 'history'),
    ]);

    quickActions.initialize((type) {
      if (type == 'Scan & pay') {
        Get.to(QrScannerScreen());
      } else if (type == 'Send Money') {
        Get.to(ToPerson());
      } else if (type == 'Show History') {
        Get.to(const Transactions());
      } else if (type == 'Tap to Speak') {
        Get.to(Mic(
          currentRoute: '/MainScreen',
        ));
      }
    });
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
    setState(() {
      isLoggedIn = true;
      appTheme = prefs.getBool('apptheme') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // SpeechController.listen('Hello how can i help you');
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MicController>(create: (_) => MicController()),
          ChangeNotifierProvider<TeluguDataController>(
              create: (_) => TeluguDataController()),
          ChangeNotifierProvider<BalanceProvider>(
              create: (_) => BalanceProvider()),
          ChangeNotifierProvider<ScrollProvider>(
              create: (_) => ScrollProvider()),
          ChangeNotifierProvider<UserController>(
              create: (context) => UserController()),
          ChangeNotifierProvider<TextFieldController>(
              create: (context) => TextFieldController()),
        ],
        child: GetMaterialApp(

            /* dark theme settings */
            darkTheme: Theme.of(context).copyWith(
              primaryColor: backgroundColorDark,
              textTheme: TextTheme(
                  bodyLarge: const TextStyle(
                          color: appTextColorDark,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)
                      .apply(
                    color: appTextColorDark,
                  ),
                  bodySmall: const TextStyle(
                    color: appTextColorDark,
                    fontSize: 14,
                  ).apply(
                    color: appTextColorDark,
                  ),
                  bodyMedium: const TextStyle(
                    color: appTextColorDark,
                    fontSize: 20,
                  ).apply(
                    color: appTextColorDark,
                  ),
                  headlineMedium: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)
                      .apply(color: appTextColorDark),
                  headlineSmall: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)
                      .apply(color: appTextColorDark)),
              scaffoldBackgroundColor: backgroundColorDark,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: AppColor),
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Color(0xFF012142))),
              brightness: Brightness.dark,
            ),
            // white theme
            theme: Theme.of(context).copyWith(
              scaffoldBackgroundColor: backgroundColor,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: Color(0xFF012142))),
              brightness: Brightness.light,
              textTheme: TextTheme(
                  bodyLarge: const TextStyle(
                          color: appTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)
                      .apply(
                    color: appTextColor,
                  ),
                  headlineMedium: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)
                      .apply(color: appTextColor),
                  bodySmall: const TextStyle(
                    color: appTextColor,
                    fontSize: 14,
                  ).apply(
                    color: appTextColor,
                  ),
                  bodyMedium: const TextStyle(
                    color: appTextColor,
                    fontSize: 20,
                  ).apply(
                    color: appTextColor,
                  ),
                  headlineSmall: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)
                      .apply(color: appTextColor)),
              primaryColor: backgroundColor,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: AppColor),
            ),
            themeMode: appTheme ? ThemeMode.dark : ThemeMode.light,
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
            getPages: [
              GetPage(
                name: '/languagePage',
                page: () => const LanguagePage(),
              ),
              GetPage(
                name: '/HomeScreen',
                page: () => const MainScreen(),
              ),
              GetPage(
                name: '/profilePage',
                page: () => const ProfilePage(),
              ),
              GetPage(
                name: '/sendPage',
                page: () => ToPerson(),
              ),
              GetPage(
                name: '/registerPage',
                page: () => SignUpPage(),
              ),
              GetPage(
                name: '/amountPage',
                page: () => AmountPage(
                  nicknameeng: '',
                  image: '',
                  nickname: '',
                ),
              ),
              GetPage(
                name: '/setPinPage',
                page: () => const PinSetUp(
                  fullName: '',
                  mobileNumber: '',
                  nickNmae: '',
                  userName: '',
                ),
              ),
              GetPage(
                name: '/ScannerPage',
                page: () => QrScannerScreen(),
              ),
              GetPage(
                name: '/QrPage',
                page: () => const QrScreen(),
              ),
              GetPage(
                name: '/ExplorePage',
                page: () => const ExploreScreen(),
              ),
              GetPage(
                name: '/TransactionsPage',
                page: () => const Transactions(),
              ),
              GetPage(
                name: '/MicPage',
                page: () => Mic(
                  currentRoute: '/Mic',
                ),
              ),
            ],
            home: SplashScreen(user: user,)));
  }
}

class MyBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

