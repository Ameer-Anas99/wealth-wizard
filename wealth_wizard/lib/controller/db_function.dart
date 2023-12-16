import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/transactions.dart';

const transactionDBName = 'Transaction_database';

class Dbprovider extends ChangeNotifier {
  Dbprovider.internal();

  static Dbprovider instance = Dbprovider.internal();

  factory Dbprovider() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  Future<void> getAllTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionListNotifier.value.clear();

    transactionListNotifier.value.addAll(transactionDB.values);

    transactionListNotifier.notifyListeners();
  }

  Future<void> insertTransaction(TransactionModel obj) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.put(obj.id, obj);
    overViewListNotifier.notifyListeners();
    getAllTransactions();
  }

  Future<void> deleteTransaction(TransactionModel transactionModel) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.delete(transactionModel.id);
    overViewListNotifier.notifyListeners();
    getAllTransactions();
  }

  Future<void> editTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.put(value.id, value);
    overViewListNotifier.notifyListeners();
    getAllTransactions();
  }
}
