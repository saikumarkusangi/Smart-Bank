import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollProvider extends ChangeNotifier {
  bool _visible = false;
  get visible {
    return _visible;
  }

  void scrolling(ScrollNotification value) {
    print('object');
    if (value.metrics.axisDirection == AxisDirection.down) {
      _visible = true;
      notifyListeners();
    }
  }
}
