import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/home_background.dart';
import 'package:wealth_wizard/view/transaction_list.dart';
import 'package:wealth_wizard/view/uppercase.dart';
import 'package:wealth_wizard/view/transactions.dart';
import 'package:wealth_wizard/view/balance.dart';

final List<String> day = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

class HomeScreen extends StatefulWidget {
  String username;
  File file;
  HomeScreen({super.key, required this.username, required this.file});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    overViewListNotifier.value =
        Dbprovider.instance.transactionListNotifier.value;
    super.initState();
    Dbprovider().transactionListNotifier;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: Dbprovider.instance.transactionListNotifier,
            builder: (context, value, index) {
              return Column(
                children: [
                  SizedBox(
                      height: screenHeight * .44,
                      width: screenWidth,
                      child: HomeBackground(
                        username: widget.username,
                        file: widget.file.path,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Transactions History',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Color.fromARGB(255, 15, 14, 14))),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TransactionList(),
                            ));
                          },
                          child: const Text('See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 15, 14, 14))),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white24,
                      height: 300,
                      child: ValueListenableBuilder(
                          valueListenable:
                              Dbprovider.instance.transactionListNotifier,
                          builder: (BuildContext ctx,
                              List<TransactionModel> newList, Widget? _) {
                            return (newList.isEmpty)
                                ? Column(
                                    children: [
                                      SizedBox(height: screenHeight / 14),
                                      const Center(
                                        child:
                                            Text('No transactions added yet'),
                                      ),
                                    ],
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.all(5),
                                    itemBuilder: (ctx, index) {
                                      final int lastIndex =
                                          transactionDB.length - 1;
                                      final int reversedIndex =
                                          lastIndex - index;
                                      final value = newList[reversedIndex];
                                      return Card(
                                        color: const Color.fromARGB(
                                            255, 248, 246, 246),
                                        elevation: 0,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 244, 240, 228),
                                            radius: 50,
                                            child: Image.asset(
                                                'assets/${value.category}.jpeg',
                                                height: 40),
                                          ),
                                          title: Text(
                                            value.explain.capitalize(),
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${value.datetime.year}-${value.datetime.day}-${value.datetime.month}  ${day[value.datetime.weekday - 1]}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          ),
                                          trailing: Text(
                                            value.amount,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19,
                                              color: value.type == 'income'
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, index) {
                                      return const Divider(
                                        height: 4,
                                        thickness: 2,
                                      );
                                    },
                                    itemCount:
                                        newList.length > 4 ? 4 : newList.length,
                                  );
                          }),
                    ),
                  )
                ],
              );
            }),
      )),
    );
  }
}
