import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
  int tabIndex = 0;

  void setTabPage(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
