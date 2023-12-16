import 'package:flutter/material.dart';
import 'package:wealth_wizard/view/home_screen.dart';
import 'package:wealth_wizard/view/settings.dart';
import 'package:wealth_wizard/view/statistics.dart';
import 'package:wealth_wizard/view/transaction_list.dart';

class BottonBarProvider extends ChangeNotifier {
  int indexcolor = 0;

  void setIndexColor(int newIndex) {
    indexcolor = newIndex;
    notifyListeners();
  }
}
