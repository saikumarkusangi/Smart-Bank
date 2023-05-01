import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldController extends ChangeNotifier {
  String nickname = '';
  String receviername = '';
  String ammount = '';
  String nick = '';
  String user = '';
  String full = '';
  String upi = '';
  String mobile = '';
  loginTextField() {
    newNickName(value: 'nick name'.tr);
  }

  Future<void> newNickName({required String value}) async {
    nickname = value;
    notifyListeners();
  }

  Future<void> newrecevierName({required String value}) async {
    receviername = value;
    notifyListeners();
  }

  Future<void> newAmmount({required String value}) async {
    ammount = value;
    notifyListeners();
  }

  Future<void> newNick({required String value}) async {
    nick = value;
    notifyListeners();
  }

  Future<void> newuser({required String value}) async {
    user = value;
    notifyListeners();
  }

  Future<void> newfull({required String value}) async {
    full = value;
    notifyListeners();
  }

  Future<void> newupi({required String value}) async {
    upi = value;
    notifyListeners();
  }

  Future<void> newmobile({required String value}) async {
    mobile = value;
    notifyListeners();
  }
}
