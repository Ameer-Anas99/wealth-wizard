import 'package:hive_flutter/adapters.dart';
import 'package:wealth_wizard/controller/db_provider.dart';
import 'package:wealth_wizard/model/add_data.dart';

int totals = 0;
final box = Hive.box<TransactionModel>(transactionDBName);

List<TransactionModel> today() {
  List<TransactionModel> a = [];
  var history = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history.length; i++) {
    if (history[i].datetime.day == date.day) {
      a.add(history[i]);
    }
  }
  return a;
}

List<TransactionModel> week() {
  List<TransactionModel> a = [];
  DateTime date = DateTime.now();
  var history = box.values.toList();
  for (var i = 0; i < history.length; i++) {
    if (date.day - 7 <= history[i].datetime.day &&
        history[i].datetime.day <= date.day) {
      a.add(history[i]);
    }
  }
  return a;
}

List<TransactionModel> month() {
  List<TransactionModel> a = [];
  DateTime date = DateTime.now();
  var history = box.values.toList();
  for (var i = 0; i < history.length; i++) {
    if (history[i].datetime.month == date.month) {
      a.add(history[i]);
    }
  }
  return a;
}

List<TransactionModel> year() {
  List<TransactionModel> a = [];
  var history = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history.length; i++) {
    if (history[i].datetime.year == date.year) {
      a.add(history[i]);
    }
  }
  return a;
}

int totalchart(List<TransactionModel> history) {
  List a = [0, 0];

  for (var i = 0; i < history.length; i++) {
    a.add(history[i].type == 'income'
        ? int.parse(history[i].amount)
        : int.parse(history[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<TransactionModel> history, bool hour) {
  List<TransactionModel> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < history.length; c++) {
    for (var i = c; i < history.length; i++) {
      if (hour) {
        if (history[i].datetime.hour == history[i].datetime.hour) {
          a.add(history[i]);
          counter = i;
        }
      } else {
        if (history[i].datetime.day == history[c].datetime.day) {
          a.add(history[i]);
          counter = i;
        }
      }
    }
    total.add(totalchart(a));
    a.clear();
    c = counter;
  }
  return total;
}
