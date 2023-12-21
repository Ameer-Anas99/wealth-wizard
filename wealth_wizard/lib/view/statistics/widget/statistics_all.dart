import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/statistics_provider.dart';
import 'package:wealth_wizard/controller/utility_provider.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Consumer2<Dbprovider, UtilityProvider>(
          builder: (context, transactionProvider, utilityProvider, child) {
            Map incomeMap = {
              'name': "Income",
              "amount": utilityProvider.income(),
            };
            Map expenseMap = {
              'name': 'Expense',
              'amount': utilityProvider.expense(),
            };
            List<Map> totalMap = [incomeMap, expenseMap];
            return transactionProvider.chartList.isEmpty
                ? const SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('No data Found'),
                      ],
                    ),
                  )
                : Consumer<StatisticsProvider>(
                    builder: (context, provider, child) {
                    return SfCircularChart(
                      tooltipBehavior: provider.tooltipBehavior,
                      series: <CircularSeries>[
                        PieSeries<Map, String>(
                            dataSource: totalMap,
                            xValueMapper: (Map data, _) => data['name'],
                            yValueMapper: (Map data, _) => data['amount'],
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            ))
                      ],
                      legend: const Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.scroll,
                          alignment: ChartAlignment.center),
                    );
                  });
          },
        ),
      ),
    );
  }
}
