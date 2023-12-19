import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/statistics/statistics.dart';

class ExpenceChart extends StatefulWidget {
  const ExpenceChart({super.key});

  @override
  State<ExpenceChart> createState() => _ExpenceChartState();
}

class _ExpenceChartState extends State<ExpenceChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<Dbprovider>(
        builder: (context, transactionprovider, child) {
          var allincome = transactionprovider.chartList
              .where((element) => element.type == 'expense')
              .toList();
          return transactionprovider.chartList.isEmpty
              ? const SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('No data found'),
                    ],
                  ),
                )
              : SfCircularChart(
                  palette: [Color.fromARGB(224, 167, 79, 71)],
                  series: <CircularSeries>[
                    PieSeries<TransactionModel, String>(
                        dataSource: allincome,
                        xValueMapper: (TransactionModel expenseDate, _) =>
                            expenseDate.category,
                        yValueMapper: (TransactionModel expenseDate, _) =>
                            num.parse(expenseDate.amount),
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
    ));
  }
}
