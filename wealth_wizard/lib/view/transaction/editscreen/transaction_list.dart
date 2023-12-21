import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:wealth_wizard/view/transaction/editscreen/widget/transaction_all.dart';
import 'package:wealth_wizard/view/transaction/editscreen/widget/transaction_expence.dart';
import 'package:wealth_wizard/view/transaction/editscreen/widget/transaction_income.dart';
import 'package:wealth_wizard/view/widget/search.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(),
          title: const Text(
            'Transactions History',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SearchField(),
            Expanded(
              child: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: ButtonsTabBar(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          tabs: const [
                            Tab(
                              iconMargin: EdgeInsets.all(30),
                              text: 'All',
                            ),
                            Tab(
                              text: "Income",
                            ),
                            Tab(
                              text: "Expense",
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          TransactionAll(),
                          TransactionIncome(),
                          TransactionExpence()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
