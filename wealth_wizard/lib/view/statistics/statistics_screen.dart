import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_provider.dart';
import 'package:wealth_wizard/controller/statistics_provider.dart';
import 'package:wealth_wizard/view/statistics/widget/statistics_all.dart';
import 'package:wealth_wizard/view/statistics/widget/statistics_expence.dart';
import 'package:wealth_wizard/view/statistics/widget/statistics_income.dart';
import 'package:wealth_wizard/view/widget/date_filter.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _TransactionInsightsAllState();
}

class _TransactionInsightsAllState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    final transactionProvider = Provider.of<Dbprovider>(context, listen: false);
    transactionProvider.allDbList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Statistics",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Consumer2<Dbprovider, StatisticsProvider>(
        builder: (context, dbProvider, statisticProvider, child) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Date  ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DateFilterStatistics(),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: ButtonsTabBar(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          tabs: const [
                            Tab(
                              iconMargin: EdgeInsets.all(30),
                              text: 'All',
                            ),
                            Tab(
                              text: 'Income',
                            ),
                            Tab(
                              text: 'Expense',
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            AllScreen(),
                            ExpenceChart(),
                            IncomeChart(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
