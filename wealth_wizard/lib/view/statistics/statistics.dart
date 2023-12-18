import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/statistics/widget/statistics_all.dart';
import 'package:wealth_wizard/view/statistics/widget/statistics_expence.dart';
import 'package:wealth_wizard/view/statistics/widget/statistics_income.dart';

ValueNotifier<List<TransactionModel>> overViewGraphNotifier =
    ValueNotifier(Dbprovider.instance.transactionListNotifier.value);

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String dateFilterTitle = 'All';

  @override
  void initState() {
    super.initState();
    overViewGraphNotifier.value =
        Dbprovider.instance.transactionListNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 13, 109),
        title: const Center(
          child: Text(
            'Statistics',
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text(
                  'Data',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<int>(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      70,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        dateFilterTitle,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 20,
                      )
                    ],
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: const Text(
                        "All",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value =
                            Dbprovider.instance.transactionListNotifier.value;
                        setState(() {
                          dateFilterTitle = 'All';
                        });
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        "Today",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value =
                            Dbprovider.instance.transactionListNotifier.value;
                        overViewGraphNotifier.value = overViewGraphNotifier
                            .value
                            .where((element) =>
                                element.datetime.day == DateTime.now().day &&
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        setState(() {
                          dateFilterTitle = "Today";
                        });
                      },
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: const Text(
                        "Yesterday",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value = Dbprovider
                            .instance.transactionListNotifier.value
                            .where((element) =>
                                element.datetime.day ==
                                    DateTime.now().day - 1 &&
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        setState(() {
                          dateFilterTitle = "Yesterday";
                        });
                      },
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: Text(
                        "Month",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value =
                            Dbprovider.instance.transactionListNotifier.value;
                        overViewGraphNotifier.value = overViewGraphNotifier
                            .value
                            .where((element) =>
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        setState(() {
                          dateFilterTitle = "Month";
                        });
                      },
                    ),
                  ],
                ),
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
                        backgroundColor: Colors.teal,
                        tabs: const [
                          Tab(
                            text: 'All',
                          ),
                          Tab(
                            text: 'Income',
                          ),
                          Tab(
                            text: 'Expanses',
                          ),
                        ]),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        AllScreen(),
                        IncomeChart(),
                        ExpenceChart(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
