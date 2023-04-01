import 'dart:async';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/textFieldController/textfield_controller.dart.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/views/features/history/history.dart';
import 'package:bank/views/features/profile/profile_page.dart';
import 'package:bank/views/features/send/send_page.dart';
import 'package:bank/views/views.dart';
import 'package:bank/views/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../views/features/balance/balance.dart';
import '../views/features/home/home.dart';

class MicController extends ChangeNotifier {
  final List _text = [];
  bool _isListening = false;
  bool notFound = true;
  bool get isListening => _isListening;
  List get text => _text;
  bool _bottomSheet = false;
  bool get bottomSheet => _bottomSheet;

  showButtomSheet() {
    _bottomSheet = true;
    notifyListeners();
  }

  listening(bool value) {
    _isListening = value;
    notifyListeners();
  }

  listen(BuildContext context) async {
    // _isListening = true;
    // notifyListeners();

    for (var e in _text) {
      print('checking for ${e} working on it');
      if (Commands.checkBalanceCommand.contains(e)) {
        if (Get.currentRoute == '/ProfilePage' ||
            Get.currentRoute == '/HomePage' ||
            Get.currentRoute == '/BalancePage') {
          notFound = false;
          notifyListeners();
          SpeechController.listen('Enter Your Pin'.tr);
          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.to(Balance());
          _text.remove(e);
          _text.clear();
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            showButtomSheet();
            _text.remove(e);
            _text.clear();
            notifyListeners();
          });
        } else {
          SpeechController.listen('login to check your balance'.tr);
          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.balanceCommandtelugu.contains(e)) {
        if (Get.currentRoute == '/ProfilePage' ||
            Get.currentRoute == '/HomePage' ||
            Get.currentRoute == '/BalancePage') {
          notFound = false;
          notifyListeners();
          SpeechController.listen('Enter Your Pin'.tr);
          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.to(Balance());
          _text.remove(e);
          _text.clear();
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            showButtomSheet();
            _text.remove(e);
            _text.clear();
            notifyListeners();
          });
        } else {
          SpeechController.listen('login to check your balance'.tr);
          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.balanceCommandtelugu.contains(e)) {
        if (Get.currentRoute == '/ProfilePage' ||
            Get.currentRoute == '/HomePage' ||
            Get.currentRoute == '/BalancePage') {
          notFound = false;
          notifyListeners();
          SpeechController.listen('Enter Your Pin'.tr);
          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.to(Balance());
          _text.remove(e);
          _text.clear();
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            showButtomSheet();
            _text.remove(e);
            _text.clear();
            notifyListeners();
          });
        } else {
          SpeechController.listen('login to check your balance'.tr);
          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.transactionsCommand.contains(e)) {
        if (Get.currentRoute == '/SendPage' ||
            Get.currentRoute == '/HomePage' ||
            Get.currentRoute == '/ProfilePage' ||
            Get.currentRoute == '/History' ||
            Get.currentRoute == '/RequestPage' ||
            Get.currentRoute == '/Balance') {
          notFound = false;
          notifyListeners();
          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.to(const History());
          _text.remove(e);
          _text.clear();
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            showButtomSheet();
            _text.remove(e);
            _text.clear();
            notifyListeners();
          });
        } else {
          SpeechController.listen('your transaction details'.tr);
          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.selectEnglish.contains(e.toString().trim()) &&
          Get.currentRoute == '/') {
        notFound = false;
        notifyListeners();
        Get.locale = const Locale('en', 'US');
        SpeechController.listen('selected language'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.to(const LoginPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.selectTelugu.contains(e.toString().trim()) &&
          Get.currentRoute == '/') {
        notFound = false;
        Get.locale = const Locale('te', 'IN');
        notifyListeners();
        SpeechController.listen('selected language'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.to(const LoginPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.sendCommand.contains(e.toString().trim())) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('going to money sending page'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.to(const SendPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
          _text.clear();
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.loginPageCommand.contains(e)) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('going to login page'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.to(const LoginPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
        break;
      }
      if (Commands.backPageCommand.contains(e)) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('going to back page'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.back();
        });
        _text.clear();
        notifyListeners();
      }
      if (Commands.signUpPageCommand.contains(e)) {
        final provider = Provider.of<UserController>(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        notFound = false;
        notifyListeners();
        SpeechController.listen('going to register page'.tr);
        provider.clearData();
        prefs.setString('nickName', '');
        prefs.setString('pin', '');
        prefs.setBool('user', false);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(const SignUpPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (Get.currentRoute == '/LoginPage') {
        final textfieldController =
            Provider.of<TextFieldController>(context, listen: false);
        print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE' + e);
        textfieldController.newNickName(value: e);
      }

      if (Get.currentRoute == '/SignUpPage') {
        print('yessss');
        print(e);
        final textfieldController =
            Provider.of<TextFieldController>(context, listen: false);
        if (e.toString().contains('nick name') ||
            e.toString().contains('nickname')) {
          textfieldController.newNick(value: e.toString().split(' ')[1]);
        }

        if (e.toString().contains('full name')) {
          textfieldController.newfull(value: e.toString().split(' ')[1]);
        }
        if (e.toString().contains('mobile')) {
          textfieldController.newmobile(value: e.toString().split(' ')[1]);
        }

        if (e.toString().contains('user name')) {
          textfieldController.newuser(value: e.toString().split(' ')[1]);
        }

        if (e.toString().contains('upi id') || e.toString().contains('upi')) {
          textfieldController.newupi(value: e.toString().split(' ')[1]);
        }
      }
      if (Get.currentRoute == '/SendPage') {
        final provider = Provider.of<UserController>(context, listen: false);
        final textfieldController =
            Provider.of<TextFieldController>(context, listen: false);
        print(e);
        if (e.toString().contains('send') &&
                e.toString().contains('to') &&
                e.toString().contains('rs') ||
            e.toString().contains('rupees')) {
          if (e.toString().contains('rupees')) {
            textfieldController.newAmmount(value: e.toString().split(' ')[1]);
          } else {
            textfieldController.newAmmount(value: e.toString().split(' ')[2]);
          }

          textfieldController.newrecevierName(
              value: e
                  .toString()
                  .split(' ')
                  .toString()
                  .replaceAll('send', '')
                  .replaceAll('rs', '')
                  .replaceAll('rupees', '')
                  .replaceAll('to', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(',', '')
                  .replaceAll(RegExp(r"\d"), "")
                  .replaceAll('  ', ''));
        }
      }

      if (Commands.homePageCommand.contains(e)) {
        if (Get.currentRoute == '/SendPage' ||
            Get.currentRoute == '/HomePage' ||
            Get.currentRoute == '/ProfilePage' ||
            Get.currentRoute == '/History' ||
            Get.currentRoute == '/RequestPage' ||
            Get.currentRoute == '/Balance') {
          notFound = false;
          notifyListeners();
          SpeechController.listen('going to home page'.tr);

          _text.clear();
          _isListening = false;
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            Get.to(const HomePage(),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 200));
          });
          _text.clear();
          notifyListeners();
        } else {
          SpeechController.listen('login to go to home page');
          _text.remove(e);
          _text.clear();
          notifyListeners();
        }
      }

      if (Commands.logoutCommand.contains(e)) {
        final provider = Provider.of<UserController>(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (Get.currentRoute == '/SendPage' ||
            Get.currentRoute == '/HomePage' ||
            Get.currentRoute == '/ProfilePage' ||
            Get.currentRoute == '/History' ||
            Get.currentRoute == '/RequestPage' ||
            Get.currentRoute == '/Balance') {
          final provider = Provider.of<UserController>(context, listen: false);
          notFound = false;
          notifyListeners();
          SpeechController.listen('you have logged out'.tr);
          provider.clearData();
          prefs.setString('nickName', '');
          prefs.setString('pin', '');
          prefs.setBool('user', false);
          _text.clear();
          _isListening = false;
          notifyListeners();
          provider.clearData();
          Get.off(const LoginPage());

          _text.clear();
          notifyListeners();
        }
      }

      if (Commands.profilePageCommand.contains(e)) {
        if (Get.currentRoute == '/SendPage' ||
            Get.currentRoute == '/HomePage' ||
            Get.currentRoute == '/ProfilePage' ||
            Get.currentRoute == '/History' ||
            Get.currentRoute == '/RequestPage' ||
            Get.currentRoute == '/Balance') {
          notFound = false;
          notifyListeners();
          SpeechController.listen('going to profile page'.tr);
          _text.clear();
          _isListening = false;
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            Get.to(const ProfilePage(),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 200));
          });
        } else {
          SpeechController.listen('login to show profile');
          _text.remove(e);
          _text.clear();
          notifyListeners();
        }
      }

      // if(notFound){
      // "క్షమించండి ఆదేశం గుర్తించబడలేదు మళ్లీ ప్రయత్నించండి"
      //   SpeechController.listen('Sorry command not recognized try again');
      //   _text.clear();
      //   _isListening = false;
      //   notifyListeners();
      // }
    }

    // SpeechController.listen('Sorry command not recognized try again');
  }
}
