import 'package:bank/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TeluguDataController extends ChangeNotifier {
  String nickname = '';
  String username = '';
  String fullname = '';
  String mobile = '';
  String upiid = '';

  changenick(val) {
    nickname = val;
    notifyListeners();
  }

  changeuser(val) {
    username = val;
    notifyListeners();
  }

    changemobile(val) {
    mobile = val;
    notifyListeners();

  }

    changefull(val) {
    fullname = val;
    notifyListeners();
  }

    chnageupi(val) {
    upiid = val;
    notifyListeners();
  }
}
