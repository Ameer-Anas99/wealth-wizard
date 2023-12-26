import 'package:flutter/material.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/service/db_services.dart';

const transactionDBName = 'Transaction_database';

class Dbprovider extends ChangeNotifier {
  // List<TransactionModel> transactionListNotifier = [];
  List<TransactionModel> chartList = [];
  List<TransactionModel> transactionList = [];
  bool isEdit = false;

  DbServices dbServicesc = DbServices();

  Future<void> getAllData() async {
    transactionList = await dbServicesc.getAllTransactions();
    notifyListeners();
  }

  Future<void> insertTransaction(TransactionModel obj) async {
    await dbServicesc.insertTransaction(obj);
    await getAllData();
  }

  Future<void> deleteTransaction(TransactionModel transactionModel) async {
    await dbServicesc.deleteTransaction(transactionModel.id);
    await getAllData();
  }

  Future<void> editTransaction(TransactionModel value) async {
    await dbServicesc.editTransaction(value);
    notifyListeners();
    await getAllData();
  }

  void allDbList() {
    chartList = transactionList;
    notifyListeners();
  }

  void isEditValueChange(bool value) {
    isEdit = value;
    notifyListeners();
  }
}
