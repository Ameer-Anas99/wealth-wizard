import 'package:flutter/material.dart';

class BottonBarProvider extends ChangeNotifier {
  int indexcolor = 0;

  void setIndexColor(int newIndex) {
    indexcolor = newIndex;
    notifyListeners();
  }
}
