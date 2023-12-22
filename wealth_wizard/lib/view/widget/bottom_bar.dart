import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/bottombar_provider.dart';
import 'package:wealth_wizard/view/home/home_screen.dart';
import 'package:wealth_wizard/view/settings/settings.dart';
import 'package:wealth_wizard/view/statistics/statistics_screen.dart';
import 'package:wealth_wizard/view/transaction/editscreen/transaction_list.dart';
import 'package:wealth_wizard/view/transaction/addscreen/add_screen.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int initialIndex = 0;
  String username;
  File file;
  BottomBar({super.key, required this.username, required this.file});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List screen = [];

  @override
  void initState() {
    super.initState();
    screen = [
      HomeScreen(username: widget.username, file: widget.file),
      const StatisticsScreen(),
      const TransactionScreen(),
      const Settings(),
    ];
    final provider = Provider.of<BottonBarProvider>(context, listen: false);
    provider.indexcolor = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottonBarProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: screen[provider.indexcolor],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddTransaction(
                      file: File('wealth_wizard/assets/Education.jpeg')),
                ),
              );
            },
            backgroundColor: Colors.purple,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 0;
                      // });
                      provider.setIndexColor(provider.indexcolor = 0);
                    },
                    child: Icon(
                      Icons.home,
                      size: 30,
                      color: provider.indexcolor == 0
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 1;
                      // });
                      provider.setIndexColor(provider.indexcolor = 1);
                    },
                    child: Icon(
                      Icons.bar_chart_outlined,
                      size: 30,
                      color: provider.indexcolor == 1
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 2;
                      // });
                      provider.setIndexColor(provider.indexcolor = 2);
                    },
                    child: Icon(
                      Icons.list,
                      size: 30,
                      color: provider.indexcolor == 2
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 3;
                      // });
                      provider.setIndexColor(provider.indexcolor = 3);
                    },
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: provider.indexcolor == 3
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
