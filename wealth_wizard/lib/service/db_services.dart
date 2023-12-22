import 'package:hive_flutter/hive_flutter.dart';
import 'package:wealth_wizard/controller/db_provider.dart';
import 'package:wealth_wizard/model/add_data.dart';

class DbServices {
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    return transactionDB.values.toList();
  }

  Future<void> insertTransaction(TransactionModel obj) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactionDB.put(obj.id, obj);
  }

  Future<void> deleteTransaction(String id) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.delete(id);
  }

  Future<void> editTransaction(TransactionModel value) async {
    try {
      final transactionDB =
          await Hive.openBox<TransactionModel>(transactionDBName);
      transactionDB.put(value.id, value);
    } catch (e) {
      print('Error editing transaction: $e');
    }
  }
}
