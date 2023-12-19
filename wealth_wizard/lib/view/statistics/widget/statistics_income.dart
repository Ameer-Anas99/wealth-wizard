import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';
import 'package:wealth_wizard/model/add_data.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white12,
      body:
          Consumer<Dbprovider>(builder: (context, transactionProvider, child) {
        var allincome = transactionProvider.chartList
            .where((element) => element.type == 'income')
            .toList();
        return transactionProvider.chartList.isEmpty
            ? const SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('No data Found'),
                  ],
                ),
              )
            : SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<TransactionModel, String>(
                      dataSource: allincome,
                      xValueMapper: (TransactionModel incomeDate, _) =>
                          incomeDate.category,
                      yValueMapper: (TransactionModel incomeDate, _) =>
                          int.parse(incomeDate.amount),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                      ))
                ],
                legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.scroll,
                    alignment: ChartAlignment.center),
              );
      }),
    ));
  }
}
