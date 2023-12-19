import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/transactions.dart';

const transactionDBName = 'Transaction_database';

class Dbprovider extends ChangeNotifier {
  // List<TransactionModel> transactionListNotifier = [];
  List<TransactionModel> chartList = [];
  List<TransactionModel> transactionList = [];

  Future<void> getAllTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    // transactionListNotifier.clear();

    // transactionListNotifier.addAll(transactionDB.values);
    transactionList.clear();
    transactionList.addAll(transactionDB.values);

    notifyListeners();
  }

  Future<void> insertTransaction(TransactionModel obj) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.put(obj.id, obj);
    getAllTransactions();
    notifyListeners();
  }

  Future<void> deleteTransaction(TransactionModel transactionModel) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.delete(transactionModel.id);
    getAllTransactions();
    notifyListeners();
  }

  Future<void> editTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.put(value.id, value);
    getAllTransactions();
    notifyListeners();
  }

  void allDbList() {
    chartList = transactionList;
    notifyListeners();
  }
}
