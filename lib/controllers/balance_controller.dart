
import 'package:flutter/material.dart';

class BalanceProvider extends ChangeNotifier {
  bool _showbalance = false;
  bool get showbalance => _showbalance;

  void front() {
    _showbalance = false;
    notifyListeners();
  }
   void back() {
    _showbalance = true;
    notifyListeners();
  }
}
