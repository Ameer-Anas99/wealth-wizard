import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/login/loginscreen.dart';

class Reset extends ChangeNotifier {
  resetApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: const Text(
              'Do you want to Reset app',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: (() async {
                  Navigator.of(context).pop();
                  final transactionDb =
                      await Hive.openBox<TransactionModel>(transactionDBName);
                  transactionDb.clear();
                  // Dbprovider().transactionListNotifier.clear();
                  // Dbprovider().transactionListNotifier.notifyListeners();
                  clearSharedPreferences();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ScreenLogin(),
                    ),
                  );

                  SharedPreferences prefe =
                      await SharedPreferences.getInstance();
                  await prefe.clear();
                }),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.green),
                  ))
            ],
          );
        });
  }
}

void clearSharedPreferences() async {
  final sharedPref = await SharedPreferences.getInstance();
  sharedPref.clear();
}
