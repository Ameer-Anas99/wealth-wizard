import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:wealth_wizard/function/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/screens/widget/splashscreen.dart';

const saveKeyName = 'User logged in';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  await Hive.openBox<TransactionModel>(transactionDBName);

  runApp(const MyApp());
  Dbprovider().getAllTransactions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wealth_wizard',
      home: ScreenSplash(
        file: '',
      ),
    );
  }
}
