import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/balance.dart';

ValueNotifier<List<TransactionModel>> overViewGraphNotifier =
    ValueNotifier(Dbprovider.instance.transactionListNotifier.value);

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? child) {
            Map incomeMap = {
              'name': "Income",
              "amount": IncomeAndExpence().income(),
            };
            Map expenseMap = {
              'name': 'Expense',
              'amount': IncomeAndExpence().expense(),
            };
            List<Map> totalMap = [incomeMap, expenseMap];
            return overViewGraphNotifier.value.isEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('No data Found'),
                      ],
                    ),
                  )
                : SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      PieSeries<Map, String>(
                          dataSource: totalMap,
                          xValueMapper: (Map data, _) => data['name'],
                          yValueMapper: (Map data, _) => data['amount'],
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                          ))
                    ],
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll,
                        alignment: ChartAlignment.center),
                  );
          },
        ),
      ),
    );
  }
}
