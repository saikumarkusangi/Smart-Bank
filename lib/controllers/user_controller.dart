import 'dart:async';

import 'package:bank/services/network_services.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  bool isLoading = false;
  List userdata = [];
  String nickName = '';
  String userName = '';
  String fullName = '';
  String phoneNumber = '';
  String pinNumber = '';
  String upiId = '';
  String currentBalance = '';
  List<Map<String, dynamic>> history = [];
  bool balance = false;

  UserController() {
    userdatafetch('', '');
    send(to: '', ammount: 0, from: '');
  }

  void showBalance(val) {
    balance = val;
    notifyListeners();
    Timer(const Duration(seconds: 5), () {
      balance = false;
      notifyListeners();
    });
  }

  clearData() {
    userdata = [];
    nickName = '';
    userName = '';
    fullName = '';
    phoneNumber = '';
    pinNumber = '';
    upiId = '';
    currentBalance = '';
    history = [];
    notifyListeners();
  }

  Future<void> transactions({required String nickName}) async {
    final response = await NetworkServices.history(nickName.trim());
    response.toString().split('}').map((e) {
      history.add({
        "date": e.split(':')[2].split(',')[0].replaceAll(RegExp("'"), ''),
        "time": "${e.split(':')[3].replaceAll(RegExp("'"), "")}:${e.split(':')[4].replaceAll(RegExp("'"), "")}",
        "to-from": e.split(':')[6].split(',')[0].replaceAll(RegExp("'"), ''),
        "amount": e.split(':')[7].split(',')[0].replaceAll(RegExp("'"), ''),
        "balance": e.split(':')[8].split(',')[0].replaceAll(RegExp("'"), '')
      });
    }).toList();

    notifyListeners();
  }

  Future<String> send(
      {required String to, required int ammount, required String from}) async {
    isLoading = true;
    notifyListeners();
    final response = await NetworkServices.send(to, ammount, from);
    isLoading = false;
    notifyListeners();
    return response.toString();
  }

  Future<void> userdatafetch(fnickName, fpinNumber) async {
    isLoading = true;
    notifyListeners();
    final data = await NetworkServices.userlogin(fnickName, fpinNumber);
    isLoading = false;
    notifyListeners();

    userdata = data.split(',');
    nickName = userdata[1].toString().split(':')[1].replaceAll(RegExp("'"), '');
    fullName = userdata[2].toString().split(':')[1].replaceAll(RegExp("'"), '');
    userName = userdata[3].toString().split(':')[1].replaceAll(RegExp("'"), '');
    pinNumber =
        userdata[4].toString().split(':')[1].replaceAll(RegExp("'"), '');
    phoneNumber =
        userdata[5].toString().split(':')[1].replaceAll(RegExp("'"), '');
    upiId = userdata[6]
        .toString()
        .split(':')[1]
        .replaceAll(RegExp("'"), '')
        .substring(
            0,
            userdata[6]
                    .toString()
                    .split(':')[1]
                    .replaceAll(RegExp("'"), '')
                    .length -
                1);

    notifyListeners();
    checkBalance(nickName: nickName);
    transactions(nickName: nickName);
  }

  Future<String> checkBalance({required String nickName}) async {
    final balance = await NetworkServices.currentBalance(nickName);
    isLoading = true;
    notifyListeners();
    currentBalance =
        balance.toString().split(':')[1].replaceAll(RegExp('}'), '');
    notifyListeners();
    isLoading = false;
    notifyListeners();
    return balance.toString().split(':')[1].replaceAll(RegExp('}'), '');
  }
}
