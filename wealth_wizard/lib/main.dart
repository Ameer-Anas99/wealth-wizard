import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/bottombar_provider.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/loginpage_provider.dart';
import 'package:wealth_wizard/controller/settingsprovider.dart';
import 'package:wealth_wizard/controller/statistics_provider.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';
import 'package:wealth_wizard/controller/utility_provider.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/widget/splashscreen.dart';

const saveKeyName = 'User logged in';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  await Hive.openBox<TransactionModel>(transactionDBName);

  runApp(const MyApp());
  Dbprovider().getAllData();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottonBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Dbprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Reset(),
        ),
        ChangeNotifierProvider(
          create: (context) => StatisticsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UtilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogingPageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'wealth_wizard',
        home: ScreenSplash(
          file: File('wealth_wizard/assets/Education.jpeg'),
        ),
      ),
    );
  }
}
