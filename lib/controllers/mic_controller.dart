import 'dart:async';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/utils/images.dart';
import 'package:bank/views/features/send/amount_Screen.dart';
import 'package:bank/views/features/send/to_person.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../services/services.dart';
import '../views/widgets/widgets.dart';

class MicController extends ChangeNotifier {
  final List _text = [];
  bool _isListening = false;
  bool notFound = true;
  bool get isListening => _isListening;
  List get text => _text;
  bool _bottomSheet = false;
  bool get bottomSheet => _bottomSheet;
  List amount = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  String receviernickname = '';
  String recevierimg = '';

  setDetails(nickname, image) {
    receviernickname = nickname;
    recevierimg = image;
  }

  showButtomSheet() {
    _bottomSheet = true;
    notifyListeners();
  }

  setEmpty() {
    _text.clear();
  }

  listening(bool value) {
    _isListening = value;
    notifyListeners();
  }

  setNotFound(bool value) {
    _isListening = value;
    notifyListeners();
  }

  listen(context, currentRoute) async {
    // _isListening = true;
    // notifyListeners();

    for (var e in _text) {
      if (Commands.checkBalanceCommand.contains(e)) {
        if (currentRoute == '/ProfilePage' ||
            currentRoute == '/HomeScreen' ||
            currentRoute == '/BalancePage') {
          notifyListeners();
          TtsApi.api('Enter Your Pin'.tr);
          notFound = true;
          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.off(PinVerifyScreen(
            auth: true,
          ));
          _text.remove(e);
          _text.clear();
          notifyListeners();
        } else {
          TtsApi.api('login to check your balance'.tr);
          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.balanceCommandtelugu.contains(e)) {
        if (currentRoute == '/ProfilePage' ||
            currentRoute == '/HomeScreen' ||
            currentRoute == '/BalancePage') {
          notifyListeners();
          TtsApi.api('Enter Your Pin'.tr);

          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.off(PinVerifyScreen(
            auth: true,
          ));
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
          TtsApi.api('login to check your balance'.tr);

          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.balanceCommandtelugu.contains(e)) {
        if (currentRoute == '/ProfilePage' ||
            currentRoute == '/HomeScreen' ||
            currentRoute == '/BalancePage') {
          notifyListeners();

          TtsApi.api('Enter Your Pin'.tr);
          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.off(PinVerifyScreen(
            auth: true,
          ));
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
          TtsApi.api('login to check your balance'.tr);
          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.transactionsCommand.contains(e)) {
        if (currentRoute == '/SendPage' ||
            currentRoute == '/HomeScreen' ||
            currentRoute == '/ProfilePage' ||
            currentRoute == '/History' ||
            currentRoute == '/RequestPage' ||
            currentRoute == '/Balance') {
          notifyListeners();
          _text.clear();
          _isListening = false;
          notifyListeners();
          Get.off(const Transactions());
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
          TtsApi.api('your transaction details'.tr);
          _text.remove(e);
          _text.clear();
          notifyListeners();
          break;
        }
      }

      if (Commands.selectEnglish.contains(e.toString().trim()) &&
          currentRoute == '/') {
        notifyListeners();
        Get.locale = const Locale('en', 'US');
        TtsApi.api('selected language'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(LoginPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.selectTelugu.contains(e.toString().trim()) &&
          currentRoute == '/') {
        Get.locale = const Locale('te', 'IN');
        notifyListeners();
        TtsApi.api('selected language'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(LoginPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.sendCommand.contains(e.toString().trim())) {
        notifyListeners();
        notFound = false;
        TtsApi.api('going to money sending page'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(
            ToPerson(),
          );
          _text.clear();
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.loginPageCommand.contains(e)) {
        notifyListeners();
        TtsApi.api('going to login page'.tr);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(LoginPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
        break;
      }
      if (Commands.backPageCommand.contains(e)) {
        notifyListeners();
        TtsApi.api('going to back page'.tr);
        setEmpty();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.back();
        });

        notifyListeners();
      }

      if (currentRoute == '/ToPerson' && e.toString().contains('name')) {
        String nickname = _text.last.toString().replaceAll(RegExp('name '), '');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(ToPerson(nickname: nickname));
        });
      }

      if (currentRoute == '/AmountPage' &&
          _text.isNotEmpty &&
          _text.last.toString().replaceAll(RegExp(' '), '') != 'try again') {
        print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@' +
            _text.toString() +
            _text.last.toString().replaceAll(RegExp(' '), ''));
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(PinVerifyScreen(
              amount: _text.last,
              name: 'sai',
              auth: true,
              page: 'paycomponent'));
        });
      }

      if (currentRoute == '/ChatScreen' && e.toString().contains('pay')) {
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off( AmountPage(
            image: recevierimg,
            nickname: receviernickname,
            nicknameeng:receviernickname,
          ));
        });
      }

      if (currentRoute == '/SignUpPage' && e.toString().contains('nickname')) {
        String nickname =
            _text.last.toString().replaceAll(RegExp('nickname '), '');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(SignUpPage(nickname: nickname));
        });
      }

      if (currentRoute == '/SignUpPage' && e.toString().contains('username')) {
        String username =
            _text.last.toString().replaceAll(RegExp('username '), '');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(SignUpPage(username: username));
        });
      }

      if (Commands.signUpPageCommand.contains(e)) {
        final provider = Provider.of<UserController>(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        notifyListeners();
        TtsApi.api('going to register page'.tr);
        provider.clearData();
        prefs.setString('nickName', '');
        prefs.setString('pin', '');
        prefs.setBool('user', false);
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(SignUpPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (currentRoute == '/LoginPage' && e.toString().contains('nickname')) {
        String nickname =
            _text.last.toString().replaceAll(RegExp('nickname '), '');

        print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@' +
            _text.toString());
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(const Duration(seconds: 3), () {
          Get.off(LoginPage(nickname: nickname));
        });
      }

      if (currentRoute == '/SignUpPage') {
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
      if (currentRoute == '/SendPage') {
        final textfieldController =
            Provider.of<TextFieldController>(context, listen: false);
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

      if (Commands.HomeScreenCommand.contains(e)) {
        if (currentRoute == '/SendPage' ||
            currentRoute == '/HomeScreen' ||
            currentRoute == '/ProfilePage' ||
            currentRoute == '/History' ||
            currentRoute == '/RequestPage' ||
            currentRoute == '/Balance') {
          notifyListeners();
          TtsApi.api('going to home page'.tr);

          _text.clear();
          _isListening = false;
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            Get.off(const MainScreen(),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 200));
          });
          _text.clear();
          notifyListeners();
        } else {
          TtsApi.api('login to go to home page');
          _text.remove(e);
          _text.clear();
          notifyListeners();
        }
      }

      if (Commands.logoutCommand.contains(e)) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (currentRoute == '/SendPage' ||
            currentRoute == '/HomeScreen' ||
            currentRoute == '/ProfilePage' ||
            currentRoute == '/History' ||
            currentRoute == '/RequestPage' ||
            currentRoute == '/MainScreen' ||
            currentRoute == '/ChatScreen' ||
            currentRoute == '/ToPerson' ||
            currentRoute == '/TransactionsPage' ||
            currentRoute == '/Balance') {
          final provider = Provider.of<UserController>(context, listen: false);

          notifyListeners();
          TtsApi.api('you have logged out'.tr);
          provider.clearData();
          prefs.setString('nickName', '');
          prefs.setString('pin', '');
          prefs.setBool('user', false);
          _text.clear();
          _isListening = false;
          notifyListeners();
          provider.clearData();
          Get.off(LoginPage());

          _text.clear();
          notifyListeners();
        }
      }

      if (Commands.profilePageCommand.contains(e)) {
        if (currentRoute == '/SendPage' ||
            currentRoute == '/HomeScreen' ||
            currentRoute == '/ProfilePage' ||
            currentRoute == '/History' ||
            currentRoute == '/RequestPage' ||
            currentRoute == '/Balance') {
          notifyListeners();
          TtsApi.api('going to profile page'.tr);
          _text.clear();
          _isListening = false;
          notifyListeners();
          Timer(const Duration(seconds: 3), () {
            Get.off(ProfilePage(),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 200));
          });
        } else {
          TtsApi.api('login to show profile');
          _text.remove(e);
          _text.clear();
          notifyListeners();
        }
      }

      if (e == 'try again') {
        notFound = false;
        notifyListeners();
      }
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" +
          notFound.toString());
      if ((Commands.backPageCommand.contains(e) &&
              Commands.HomeScreenCommand.contains(e) &&
              Commands.HomeScreenCommandTelugu.contains(e) &&
              Commands.balanceCommandtelugu.contains(e) &&
              Commands.checkBalanceCommand.contains(e) &&
              Commands.createCommandTelugu.contains(e) &&
              Commands.deleteAccountCommandTelugu.contains(e) &&
              Commands.loginPageCommand.contains(e) &&
              Commands.loginPageCommandTelugu.contains(e) &&
              Commands.logoutCommand.contains(e) &&
              Commands.logoutCommandTelugu.contains(e) &&
              Commands.profileCommandTelugu.contains(e) &&
              Commands.profilePageCommand.contains(e) &&
              Commands.selectEnglish.contains(e) &&
              Commands.selectTelugu.contains(e) &&
              Commands.sendCommand.contains(e) &&
              Commands.sendCommandTelugu.contains(e) &&
              Commands.signUpPageCommand.contains(e) &&
              Commands.transactionsCommand.contains(e)) ==
          false) {
        if (e == 'try again') {
          notFound = false;
          notifyListeners();
        } else {
          notFound = true;
          notifyListeners();
        }
      }
    }

    // SpeechController.listen('Sorry command not recognized try again');
  }
}
