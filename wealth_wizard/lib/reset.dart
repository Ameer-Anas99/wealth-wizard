import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/intro/loginscreen.dart';

class reset extends ChangeNotifier {
  resetApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(
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
                  Dbprovider().transactionListNotifier.value.clear();
                  Dbprovider().transactionListNotifier.notifyListeners();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ScreenLogin(),
                    ),
                  );

                  SharedPreferences prefe =
                      await SharedPreferences.getInstance();
                  await prefe.clear();
                }),
                child: Text(
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
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.green),
                  ))
            ],
          );
        });
  }
}
