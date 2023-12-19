import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';
import 'package:wealth_wizard/controller/utility_provider.dart';
import 'package:wealth_wizard/view/home/widget/home_background.dart';
import 'package:wealth_wizard/view/transaction/editscreen/widget/transaction_all.dart';
import 'package:wealth_wizard/view/uppercase.dart';

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
    super.initState();
    final provider = Provider.of<Dbprovider>(context, listen: false);
    provider.getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SafeArea(
        child: Consumer<Dbprovider>(builder: (context, provider, index) {
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
                          builder: (context) => const TransactionAll(),
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
                  child: Consumer2<Dbprovider, UtilityProvider>(
                      builder: (context, provider, provider2, child) {
                    return (provider.transactionList.isEmpty)
                        ? Column(
                            children: [
                              SizedBox(height: screenHeight / 14),
                              const Center(
                                child: Text('No transactions added yet'),
                              ),
                            ],
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(5),
                            itemBuilder: (ctx, index) {
                              final int lastIndex =
                                  provider2.transactionDB.length - 1;
                              final int reversedIndex = lastIndex - index;
                              final value =
                                  provider.transactionList[reversedIndex];
                              return Card(
                                color: const Color.fromARGB(255, 248, 246, 246),
                                elevation: 0,
                                child: Consumer<TransactionProvider>(
                                    builder: (context, provider, child) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
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
                                      '${value.datetime.year}-${value.datetime.day}-${value.datetime.month}  ${provider.day[value.datetime.weekday - 1]}',
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
                                  );
                                }),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const Divider(
                                height: 4,
                                thickness: 2,
                              );
                            },
                            itemCount: provider.transactionList.length > 4
                                ? 4
                                : provider.transactionList.length,
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
